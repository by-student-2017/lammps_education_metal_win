import sys
import numpy as np
from scipy.optimize import curve_fit

def linear_model_fit(x, x0, slope):
    return slope*x+x0

def main(stemperature=2.0, sdensity=0.8, sysname="density-real"):

    temperature = round(float(stemperature),1)
    density = round(float(sdensity),1)

    # read in the fitting result at each k
    # k_sqr kx ky kz DT b fitting_error
    results_allk = np.loadtxt('T-'+str(temperature)+'-D-'+str(density)+'-1/fit-autocorr-'+sysname+'.dat', skiprows=0)[:,:]
    num_results = len(results_allk)

    k = np.sqrt(results_allk[1:,0])
    #print(k)
    DT = results_allk[1:,4]
    #print(DT)
    b = results_allk[1:,5]
    error = results_allk[1:,6]
    #avg_error = np.mean(error)
    
    # Weighted fit
    popt, pcov = curve_fit(linear_model_fit, k, DT, sigma=error, absolute_sigma=False)
    #yfit = linear_model_fit(k, *popt)
    #print('Weighted fit parameters:', popt)
    #print('Covariance matrix:'); print(pcov)
    print(temperature, density, 'Weighted_fit_DT:', popt[0], 'k_depedent_slope_DT:', popt[1])

    popt2, pcov2 = curve_fit(linear_model_fit, k, b, sigma=error, absolute_sigma=False)
    #yfit = linear_model_fit(k, *popt)
    #print('Weighted fit parameters:', popt)
    #print('Covariance matrix:'); print(pcov)
    print(temperature, density, 'Weighted_fit_b:', popt2[0], 'k_depedent_slope_b:', popt2[1])


    #np.savetxt("fit-autocorr-"+sysname+".dat", results_allk ,header='# k_sqr kx ky kz DT b fitting_error')

if __name__ == '__main__':
    main(sys.argv[1],sys.argv[2], sys.argv[3])
