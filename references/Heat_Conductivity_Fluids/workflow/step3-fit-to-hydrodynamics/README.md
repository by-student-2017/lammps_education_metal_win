Two ways of getting the fitting coefficients
1. direct fit using curve_fit
2. fit using a grid search

for t in 0.7 0.8 1.0 1.2 1.4 1.6 1.8 2.0; do 
for d in 0.2 0.4 0.6 0.8; do 
cd T-$t-D-$d-1; 
python ../../workflow/step3-fit-to-hydrodynamics/fit_fft_density_results.py $t $d density-real; 
cd ..; done; done
