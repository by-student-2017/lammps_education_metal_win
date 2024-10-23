import sys
import numpy as np
import scipy
from scipy import signal

def smooth(y, box_pts):
    box = np.ones(box_pts)/box_pts
    y_smooth = np.convolve(y, box, mode='same')
    return y_smooth

def normalized(x):
    nx = x - np.mean(x)*np.ones(len(x))
    nx /= np.std(nx)
    return nx

def rfftranform(x,dlen=10000):
    # input: a list of real signals {x} with timestep dt
    # output: x(omega)
    
    # this is the FFT expansion coeficients assuming inputs are real numbers
    # https://docs.scipy.org/doc/numpy-1.13.0/reference/routines.fft.html#module-numpy.fft
    dt = x[1,0] - x[0,0] # assume the timestep is constant
    window = len(x)//dlen
    #print dlen
    omega0 = 2.0*np.pi/dlen/dt
    xomega = np.zeros((dlen//2 + 1,2),dtype=np.complex_)
    xomega[:,0] = np.arange(dlen//2 + 1)*omega0
    
    for i in range(window):
        dx = x[i*dlen:(i+1)*dlen,1]        
        Ax = np.fft.rfft(dx[:] , axis = 0)
        #print len(Ax)
        xomega[:,1] += Ax * dt
    xomega[:,1]/=window
    # return [omega, A(omega)]
    return xomega

def irfftranform(xomega):
    
    # first retrieve the descrete rFFT coefficients
    omega0 = xomega[1,0] - xomega[0,0]
    dlen = 2*(len(xomega)-1)
    dt = 2.0*np.pi/dlen/omega0
    Ax = xomega[:,1]
    x = np.fft.irfft(Ax[:] , axis = 0)/dt
    return x

def rfftcrosscorr(x,y,dlen=10000):
    # the fft coecofficents of the crosscorrelation function c_xy(t)
    dt = x[1,0] - x[0,0] # assume the timestep is constant
    window = len(x)//dlen
    omega0 = 2.0*np.pi/dlen/dt
    #print("omega0=",omega0)
    cxyomega = np.zeros((dlen//2 + 1,2),dtype=np.complex_)
    cxyomega[:,0] = np.arange(dlen//2 + 1)*omega0
    
    for i in range(window):
        dx = x[i*dlen:(i+1)*dlen,1] 
        dy = y[i*dlen:(i+1)*dlen,1]
        Ax = np.fft.rfft(dx[:] , axis = 0)
        Ay = np.fft.rfft(dy[:] , axis = 0)

        cxyomega[:,1] += np.conjugate(Ax[:]) * Ay[:]/dlen*dt
        
    for i in range(window-1):
        dx = x[i*dlen+dlen//2:(i+1)*dlen+dlen//2,1] 
        dy = y[i*dlen+dlen//2:(i+1)*dlen+dlen//2,1]
        Ax = np.fft.rfft(dx[:] , axis = 0)
        Ay = np.fft.rfft(dy[:] , axis = 0)

        cxyomega[:,1] += np.conjugate(Ax[:]) * Ay[:]/dlen*dt
        
    cxyomega[:,1]/=(window*2-1)
    return cxyomega

def main(sysname="density-real", smaxlength=1000):
####################################
    maxlength = int(smaxlength)
    n_k = np.loadtxt("df-"+sysname+".dat", skiprows=0)[:,:]
    timestep = 0.0025*20
    tx = np.zeros((len(n_k),2))
    tx[:,0] = timestep * np.arange(len(n_k))
    fft_cxx =  np.zeros((maxlength//2+1,512))

    for i in range(1,512):
        tx[:,1] = normalized(n_k[:,i])
        n_k_fxx = rfftcrosscorr(tx,tx,maxlength)
        fft_cxx[:,i] = n_k_fxx[:,1]
    fft_cxx[:,0] = n_k_fxx[:,0]
    np.savetxt("fft-"+sysname+".dat", np.real(fft_cxx), fmt='%1.4e', header='# omega FFT(C(n_k))(omega)')

if __name__ == '__main__':
    main(*sys.argv[1:])
