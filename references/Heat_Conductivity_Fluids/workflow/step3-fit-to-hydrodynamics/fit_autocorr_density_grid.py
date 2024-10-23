import sys
import numpy as np
import scipy
#import matplotlib.pyplot as plt
from math import pi

def S_k_omega(w,ksqr,gamma,DT,cs,b):
    """
    gamma: cp/cv
    DT: heat diffusivity
    cs: speed of sound
    b: Kinematic longitudinal viscosity
    ca: sound attentation
    """
    k = np.sqrt(ksqr)
    # sound attenuation constant
    ca = (gamma-1)/2.*DT + b/2.
    pole1 = (w+cs*k)**2 + (ca*ksqr)**2
    pole2 = (w-cs*k)**2 + (ca*ksqr)**2
    Skw = (gamma-1.)/gamma*(2.*DT*ksqr)/(w**2+(DT*ksqr)**2)
    Skw += (ca*ksqr/gamma)*(1./pole1+1./pole2)
    return Skw

def C_k_t(t,ksqr,gamma,DT,cs,b):
    """
    time correlaion function of n(k,t)
    """
    k = np.sqrt(ksqr)
    # sound attenuation constant
    ca = (gamma-1)/2.*DT + b/2.
    Ckt = (gamma-1.)/gamma*np.exp(-DT*ksqr*t)
    Ckt += 1./gamma*np.exp(-ca*ksqr*t)*np.cos(cs*k*t)
    return Ckt

def main(stemperature=1.0, sdensity=0.2, sysname="density-real"):

    temperature = round(float(stemperature),1)
    density = round(float(sdensity),1)
    numk = 512
    timestep = 0.0025 * 20

    # read in the thermal properties
    thermal_list = np.genfromtxt("../thermal-properties.dat")
    thermal_dict = {0:{0:[]}}
    for entry in thermal_list:
        T = round(entry[0],1)
        thermal_dict[T]={}
    for entry in thermal_list:
        T = round(entry[0],1)
        D = round(entry[1],1)
        thermal_dict[T][D] = entry[2:]
    [ cv_now, cp_now, gamma_now, Xt_now, cs_now ] = thermal_dict[temperature][density]

    # read in the k grid
    k_grid = np.loadtxt("kgrid.dat", skiprows=0)[:,:]
    # read in the correlation funcatin
    n_k_autocorr = np.loadtxt("autocorr-"+sysname+".dat", skiprows=0)[:,:]
    tlist = timestep*np.arange(len(n_k_autocorr))

    # get parameter at different k
    results_allk = np.zeros((numk,7), dtype=float)
    results_allk[:,1:4] = k_grid[:,:]

    for testindex in range(1,numk):
        fitresult = []
        ksqr_now = np.sum(np.square(k_grid[testindex]))
        for fitdt in np.arange(0.1, 12.0, 0.1):
            for fitb in np.arange(0.1, 8.0, 0.1):
                model_fit = C_k_t(tlist, ksqr_now, gamma_now , fitdt/cp_now, cs_now, fitb)
                fitresult.append([fitdt, fitb, np.sum(np.square(model_fit-n_k_autocorr[:,testindex]))])
        fitresult.sort(key=lambda x:x[2])
        results_allk[testindex, 0] = ksqr_now
        results_allk[testindex, -3:] = fitresult[0]
        print(results_allk[testindex])

    np.savetxt("fit-autocorr-"+sysname+".dat", results_allk ,header='# k_sqr kx ky kz DT b fitting_error')

if __name__ == '__main__':
    main(sys.argv[1],sys.argv[2], sys.argv[3])
