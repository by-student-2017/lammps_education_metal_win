%/*----------------------------------------------------------------------
%    TPI : Thermal Parameters Identification MATLAB script file
%
%
%    Copyright (c) 2014, Regents of the University of Minnesota.  All rights reserved.
%    Contributor: Amit  Singh    Email : sing0335@umn.edu
%    Advisor:     Ellad Tadmor   Email : tadmor@aem.umn.edu
%               
%    The contents of this file is distributed under the GNU General Public License.
%
%    Release: This file is part of the tpi package.
% ------------------------------------------------------------------------- */

function tpi 
close all;
fin = fopen('TPI.INPUT','r');

string = fscanf(fin,'%s',1);
if (strcmp(string,'model'))
    string = fscanf(fin,'%s',1);
    if (strcmp(string,'Jeffreys'))  %% Model to be fit
        model_flag = 1;
    elseif (strcmp(string,'CV'))
        model_flag = 2;
    elseif (strcmp(string,'Fourier'))
        model_flag = 3;
    else
        disp('Please check the input file and see if Jeffreys or CV or Fourier exists as an option to the variable "model"');
        return;
    end
else
    disp('Please check the input file and see if model exists as an input variable');
    return;
end

% Total number of columns in the nemd data files. Its value must be either 2 or
% 3. The first, second and third column refer to the bin numbers, temperatures of
% the bins and $x$-components of the heat current (heat-flux times volume of the
% bin) vectors, respectively. It should be 3 for the Jeffreys-type model, since
% both temperature and heat current data are needed. For either the CV or the
% Fourier model, its value can be either 2 or 3, because these models need only
% temperature data. The heat current data can be ignored for these two models.

string = fscanf(fin, '%s',1);
if (strcmp(string,'nemdFileCols'))
    nemdFileCols = fscanf(fin, '%d');
    if (model_flag == 1) && (nemdFileCols ~= 3)
        disp('Please check the input file and see if variable nemdFileCols has the value 3');
        return;
    elseif (model_flag == 2 || model_flag == 3) && ~(nemdFileCols == 2 || nemdFileCols == 3)
        disp('Please check the input file and see if variable nemdFileCols has the value either 2 or 3');
        return;
    end
else
    disp('Please check the input file and see if nblocks exists as an input variable');
    return;
end

string = fscanf(fin, '%s',1);
if (strcmp(string,'nEnsembles'))
    nEnsembles = fscanf(fin, '%d'); %% Total number of realizations (ensembles) available
else
    disp('Please check the input file and see if nEnsembles exists as an input variable');
    return;
end

string = fscanf(fin, '%s',1);
if (strcmp(string,'nblocks'))
    nblocks = fscanf(fin, '%d'); %% Total number of blocks (sets) in which the ensembles can be grouped together
else
    disp('Please check the input file and see if nblocks exists as an input variable');
    return;
end

nblockEns = floor(nEnsembles/nblocks); %% Number of ensembles (realizations) in a given block (set)

string = fscanf(fin,'%s',1);
if (strcmp(string,'nemdFileOption'))
    string = fscanf(fin,'%s',1);
    if (strcmp(string,'LAMMPS'))  
        for i = 1:nEnsembles
            if nemdFileCols == 2
                str = sprintf('temp.%d.ensemble',i);
            elseif nemdFileCols == 3
                str = sprintf('tempCurrent.%d.ensemble',i);
            end
            file(i) = fopen(str,'r');
            try 
                tline = fgets(file(i));
            catch exception
                disp(sprintf('File for ensemble %d not available: Please check the value of nEnsembles in the input file.', i)); 
                return;
            end
            tline = fgets(file(i));
            tline = fgets(file(i));
        end
    elseif (strcmp(string,'MANUAL'))  
        for i = 1:nEnsembles
            string = fscanf(fin,'%s',1);
            file(i) = fopen(string,'r');
            try 
                tline = fgets(file(i));
            catch exception
                disp(sprintf('File for ensemble %d not available: Please verify the value of nEnsembles and the list of file names in the input file.', i)); 
                return;
            end
            tline = fgets(file(i));
            tline = fgets(file(i));
        end
    else
        disp('Please check the input file and see if lammps or manual exists as an option to the variable "nemdFileOption"');
        return;
    end
else
    disp('Please check the input file and see if nemdFileOption exists as an input variable');
    return;
end

string = fscanf(fin, '%s',1);
if (strcmp(string,'nprofs'))
    nprofs = fscanf(fin, '%d'); %% Total number of temperature profiles available
else
    disp('Please check the input file and see if nprofs exists as an input variable');
    return;
end

string = fscanf(fin, '%s',1);
if (strcmp(string,'deltat'))
    deltat = fscanf(fin, '%f'); %% Time difference in pico seconds between two consecutive profiles recorded in the input file 
else
    disp('Please check the input file and see if deltat exists as an input variable');
    return;
end

time = [1:nprofs]*deltat;  %% total time 

string = fscanf(fin, '%s',1);
if (strcmp(string,'theta0'))
    theta0 = fscanf(fin, '%f'); %% Base or mean temperature of initial sinusoidal temperature distribution in Kelvin
else
    disp('Please check the input file and see if theta0 exists as an input variable');
    return;
end

string = fscanf(fin, '%s',1);
if (strcmp(string,'dtheta0'))
    dtheta0 = fscanf(fin, '%f'); %% Amplitude of the sinusoidal temperature distribution in Kelvin
else
    disp('Please check the input file and see if dtheta0 exists as an input variable');
    return;
end

string = fscanf(fin,'%s',1);
if (strcmp(string,'nbins'))
    nbins = fscanf(fin,'%d'); %% Total number of bins
else
    disp('Please check the input file and see if nbins exists as an input variable');
    return;
end

% Usually the length of the bin = the number of unit cells for each bin *
% lattice parameter
string = fscanf(fin,'%s',1);
if (strcmp(string,'binL'))
    binL = fscanf(fin,'%f'); %% Length of a single bin in \AA 
else
    disp('Please check the input file and see if binL exists as an input variable');
    return;
end

string = fscanf(fin,'%s',1);
if (strcmp(string,'binVol'))
    binVol = fscanf(fin,'%f'); %% Volume of a single bin in \AA^3
else
    disp('Please check the input file and see if binVol exists as an input variable');
    return;
end

% Volumetric specific heat in eV/(Ang^3K); standard error in gamma remains very
% small so its effect is not taken into account
string = fscanf(fin,'%s',1);
if (strcmp(string,'gamma'))
    gamma = fscanf(fin, '%e'); 
else
    disp('Please check the input file and see if gamma exists as an input variable');
    return;
end

maxTau = 4; %ps
gkappa = [0.1:0.1:0.4]; % W/mk
gtau_q = [0.1 0.2:0.1:1 2:maxTau];    

x = [0:nbins-1]; %% Integer position of each bin 
intL = (nbins-1);  %% Dist between the last and the first probe in terms of bin length

theta = rand(nbins,nprofs+1);  %% Temperature profile

theta(:,1) =  theta0 + dtheta0*cos(2*pi*x/intL); %% Initial conditions

ratioTheta = rand(1,nprofs); %% Cosine average of temperature along length of the beam divided by amplitude of the sinusoidal temperature distribution

% scale to convert the units of thermal conductivity into W/mK when heat
% current is expressed in eV*Ang/ps; heat current = heat flux * binvol 
eVtoJoule = 1602.17657;  

% a variable so that sine average of heat flux can be divided by pi*dtheta0 to
% get a ratio whose analytical expression is fitted over the NEMD data;
% binVol/eVtoJoule is being multiplied so that heat current can be converted
% into heat flux (q_x = J_x/V_bin), and the final unit of heat flux is W/m^2;
% binL is divided because x is in integer.
dflux0 = pi*dtheta0 * (binVol/eVtoJoule)/binL; 
ratioFlux = rand(1,nprofs); %% Sine average of heat-flux along length of the beam divided by dflux0

gamma = eVtoJoule * gamma; % to take care of unit conversion when time is in ps, 

ls = {'-','--',':','-.'};
ms = {'+','o','*','x','s','d','^','v','>','<','p','h'};
cs = {'b','g','r','k','c','m'};


kappaJeff(1:nblocks) = 0;   % k for the Jeffreys-type model
tau_TJeff(1:nblocks) = 0;   % \tau_\theta for the Jeffreys-type model
tau_qJeff(1:nblocks) = 0;   % \tau_q for the Jeffreys-type model
CaseJeff(1:nblocks) = 0;  % The minimization is done over three cases of (lambda_2)^2 > 0, < 0, = 0
resnJeff(1:nblocks) = 0;    % Residual error between the NEMD data and the fit data

kappaCV(1:nblocks) = 0;     % k for the CV model
tau_qCV(1:nblocks) = 0;     % \tau_q for the CV model
CaseCV(1:nblocks) = 0;    % The minimization is done over three cases of (lambda_2)^2 
resnCV(1:nblocks) = 0;      % Residual error between the NEMD data and the fit data

kappaFou(1:nblocks) = 0;    % k for the Fourier  model

omega = (2*pi/(intL*binL));
factor = (omega^2)/gamma;
    
% Functions for CV: 1, 2, 3 refer to the cases when (lambda_2)^2 > 0, < 0, = 0. 
modelCV1 = @(p,t)exp(p(1).*t).*(cos(p(2).*t)-(p(1)/p(2)).*sin(p(2).*t));
modelCV2 = @(p,t)(exp(p(1).*t)./(2*p(2))).*(((p(2)-p(1)).*exp(p(2).*t))+((p(2)+p(1)).*exp(-p(2).*t)));
modelCV3 = @(p,t)exp(p.*t).*(1-p*t);

% Functions for Fourier
modelFou = @(p,t)exp((-(omega^2)*p).*t);

figure;
xlabel('Time [ps]');
ylabel('\Delta\theta(t) / \Delta\theta(0)');
hAx1 = gca;
hold on;

if model_flag == 1
    figure;
    xlabel('Time [ps]');
    ylabel('\Delta q(t) / \Delta q(0)');
    hAx2 = gca;
    hold on;
end

maxnorm = 999999;

for nb = 1:nblocks
     for j=1:nprofs
        B = zeros(nemdFileCols,nbins);      
        for lo = 1:nblockEns
            num = (nb-1)*nblockEns+lo;
            if nemdFileCols == 3
                try
                    B = B + fscanf(file(num), '%d %25f %25e',[3 nbins]);
                catch exception
                    disp(sprintf('%d profiles not available in the ensemble file number %d', nprofs, num)); 
                end
            elseif nemdFileCols == 2
                try
                    B = B + fscanf(file(num), '%d %25f',[2 nbins]);
                catch exception
                    disp(sprintf('%d profiles not available in the ensemble file number %d', nprofs, num)); 
                end
            end
        end
        B = B/nblockEns;
        theta(:,j+1) = B(2,:);
        ratioTheta(j) = (2.0/intL)*trapz(x,(theta(:,j+1).*cos(2*pi*x/intL)'))/dtheta0;

        if model_flag == 1
            flux(:,j) = B(3,:);
            ratioFlux(j) = trapz(x,(flux(:,j).*sin(2*pi*x/intL)'))/dflux0; 
        end
     end

%% CV parameters 
    resnorm1 = maxnorm;
    resnorm2 = maxnorm;
    resnorm3 = maxnorm;
     
    clear p;
    if (model_flag == 1 || model_flag == 2)
        for i=1:size(gkappa,2)
            for j=1:size(gtau_q,2)
                D = factor*gkappa(i);
                alpha = -0.5*(1/gtau_q(j));
                beta2 = D/gtau_q(j) - alpha^2;
                if (beta2 > 0)
                    beta = sqrt(beta2);
                    try
                        [p,resNorm1,res,exitflag] = lsqcurvefit(modelCV1,[alpha beta],time,ratioTheta);
                    catch exception
                        continue;
                    end
                    if ((resNorm1 < resnorm1) && (exitflag == 3 || exitflag == 1)) 
                        resnorm1 = resNorm1;
                        pcv1 = p;
                    end
                elseif (beta2 < 0)
                    beta = sqrt(-beta2);
                    try
                        [p,resNorm2,res,exitflag] = lsqcurvefit(modelCV2,[alpha beta],time,ratioTheta);
                    catch exception
                        continue;
                    end
                    if ((resNorm2 < resnorm2) && (exitflag == 3 || exitflag == 1)) 
                        resnorm2 = resNorm2;
                        pcv2 = p;
                    end
                else
                    try
                        [p,resNorm3,res,exitflag] = lsqcurvefit(modelCV3,[alpha],time,ratioTheta);
                    catch exception
                        continue;
                    end
                    if ((resNorm3 < resnorm3) && (exitflag == 3 || exitflag == 1)) 
                        resnorm3 = resNorm3;
                        pcv3 = p;
                    end               
                end
            end
        end  
       
        minnorm = min([resnorm1 resnorm2 resnorm3]);
        if(minnorm < maxnorm) 
            disp(sprintf('CV Residual Norms for three options\n %f\t%f\t%f\n',resnorm1,resnorm2,resnorm3));
        else
            disp(sprintf('Minimization failed for the CV model: Try changing\n initial guesses for parameters or try changin the number of blocks/sets or try reducing the noise in\n the profiles by taking more ensembles\n\n'));
        end
        
        if (minnorm == resnorm1 && minnorm ~= maxnorm)
            p = pcv1;
            tau_qCV(nb) = -0.5/p(1);
            D = (p(1)^2+p(2)^2)*tau_qCV(nb);      
            kappaCV(nb) = D/factor;
            resnCV(nb) = resnorm1/(nprofs-1);
            ratioThetaModel = modelCV1(p,time);
            CaseCV(nb) = 1;
        elseif (minnorm == resnorm2 && minnorm ~= maxnorm) 
            p = pcv2;      
            tau_qCV(nb) = -0.5/p(1); 
            D = (p(1)^2-p(2)^2)*tau_qCV(nb);      
            kappaCV(nb) = D/factor;
            resnCV(nb) = resnorm2/(nprofs-1);
            ratioThetaModel = modelCV2(p,time);
            CaseCV(nb) = 2;
        elseif (minnorm == resnorm2 && minnorm ~= maxnorm) 
            p = pcv3;      
            tau_qCV(nb) = -0.5/p(1); 
            D = (p(1)^2)*tau_qCV(nb);      
            kappaCV(nb) = D/factor;
            resnCV(nb) = resnorm3/(nprofs-1);
            ratioThetaModel = modelCV3(p,time);
            CaseCV(nb) = 3;        
        else     %% If min is not found 
            p = 0;      
            tau_qCV(nb) = -1;     %negative values are given for this
            kappaCV(nb) = -1;
            resnCV(nb) = -1;
            ratioThetaModel = ratioTheta; 
            CaseCV(nb) = 0;        
        end
        plot(hAx1,time,ratioTheta,'-',time,ratioThetaModel,[ls{(mod(2,length(ls))+1)},cs{(mod(2,length(cs))+1)}],'Linewidth', 2);
    end
    
%% Jeffreys-type parameters
    resnorm1 = maxnorm;
    resnorm2 = maxnorm;
    resnorm3 = maxnorm;
    
    if (model_flag == 1)
        q = p;
        
        % Functions for Jeffreys-type: 1, 2, 3 refer to the cases when
        % (lambda_2)^2  > 0, < 0, = 0. 
        k1 = @(tauq)(-(1+2*q(1)*tauq)/(factor*tauq));
        modelJeffTauq1 = @(tauq,t)(((q(1)^2+q(2)^2)/(factor*q(2))).*exp(q(1).*t).*sin(q(2).*t) + k1(tauq)*exp(-t/tauq));
    
        k2 = @(tauq) ((q(1)*tauq+1)^2 - (q(2)*tauq)^2)/(factor*tauq);
        facm1 = @(tauq)((k1(tauq)+(k2(tauq)/(tauq*(q(1)+q(2)+1/tauq))))*(q(2)-q(1)));
        facm2 = @(tauq)((k1(tauq)+(k2(tauq)/(tauq*(q(1)-q(2)+1/tauq))))*(q(2)+q(1)));
        modelJeffTauq2 = @(tauq,t)(((exp(q(1).*t)./(2*q(2))).*((facm1(tauq).*exp(q(2).*t))+(facm2(tauq).*exp(-q(2).*t))))  + (k1(tauq)*exp(-t/tauq)));
    
        k3 = @(tauq)((q(1)*tauq+1)^2)/(factor*tauq);
        modelJeffTauq3 = @(tauq,t)(-((k1(tauq)+(k3(tauq)/(q(1)+1/tauq))).*exp(q(1).*t)*q(1)*t) + k1(tauq)*exp(-t/tauq)); 
    
        for j=1:size(gtau_q,2)
            if (CaseCV(nb) == 1) 
                try
                    [tau,resNorm1,res,exitflag] = lsqcurvefit(modelJeffTauq1,gtau_q(j),time,ratioFlux);
                catch exception
                    continue;
                end
                k = (q(1)^2+q(2)^2)*tau/factor;
                tauT = -(1+2*q(1)*tau)/(factor*k);
                p = [k tau tauT];
                if ((resNorm1 < resnorm1) && (size(p(p>=0),2) == 3) && (isreal(p) == 1) && (exitflag == 3 || exitflag == 1))     
                    resnorm1 = resNorm1;
                    taujeff1 = tau;
                end
            elseif (CaseCV(nb) == 2) 
                try
                   [tau,resNorm2,res,exitflag] = lsqcurvefit(modelJeffTauq2,gtau_q(j),time,ratioFlux);
                catch exception
                    continue;
                end
                k = k1(tau)+k2(tau);
                tauT = -(1+2*q(1)*tau)/(factor*k);
                p = [k tau tauT];
                if ((resNorm2 < resnorm2) && (size(p(p>=0),2) == 3) && (isreal(p) == 1) &&  (exitflag == 3 || exitflag == 1))
                    resnorm2 = resNorm2;
                    taujeff2 = tau;
                end
            elseif (CaseCV(nb) == 3) 
                try
                   [tau,resNorm3,res,exitflag] = lsqcurvefit(modelJeffTauq3,gtau_q(j),time,ratioFlux);
                catch exception
                    continue;
                end
                k = (q(1)^2)*tau/factor;
                tauT = -(1+2*q(1)*tau)/(factor*k);
                p = [k tau tauT];
                if ((resNorm3 < resnorm3) && (size(p(p>=0),2) == 3) && (isreal(p) == 1) &&  (exitflag == 3 || exitflag == 1))
                    resnorm3 = resNorm3;
                    taujeff3 = tau;
                end
            end            
        end
        
        minnorm = min([resnorm1 resnorm2 resnorm3]);    
        if(minnorm < maxnorm) 
            disp(sprintf('Jeffreys-type Residual Norms for three options\n %f\t%f\t%f\n',resnorm1,resnorm2,resnorm3));
        else
            disp(sprintf('Minimization failed for the Jeffreys-type model: Try changing\n initial guesses for parameters or try changin the number of blocks/sets or try reducing the noise in\n the profiles by taking more ensembles\n\n'));
        end
        
        if (minnorm == resnorm1 && minnorm ~= maxnorm)
            tau = taujeff1;
            kappaJeff(nb) = (q(1)^2+q(2)^2)*tau/factor;        
            tau_qJeff(nb) = tau; 
            tau_TJeff(nb) = -(1+2*q(1)*tau)/(factor*kappaJeff(nb));
            resnJeff(nb) = resnorm1/(nprofs-1);
            ratioFluxModel = modelJeffTauq1(tau,time);
            CaseJeff(nb) = 1;
        elseif (minnorm == resnorm2 && minnorm ~= maxnorm)
            tau = taujeff2;
            kappaJeff(nb) = (q(1)^2-q(2)^2)*tau/factor;        
            tau_qJeff(nb) = tau; 
            tau_TJeff(nb) = -(1+2*q(1)*tau)/(factor*kappaJeff(nb));
            resnJeff(nb) = resnorm2/(nprofs-1);
            ratioFluxModel = modelJeffTauq2(tau,time);
            CaseJeff(nb) = 2;
        elseif (minnorm == resnorm3 && minnorm ~= maxnorm)
            tau = taujeff2;
            kappaJeff(nb) = (q(1)^2)*tau/factor;        
            tau_qJeff(nb) = tau; 
            tau_TJeff(nb) = -(1+2*q(1)*tau)/(factor*kappaJeff(nb));
            resnJeff(nb) = resnorm3/(nprofs-1);
            ratioFluxModel = modelJeffTauq3(tau,time);
            CaseJeff(nb) = 3;        
        else  % If min is not found 
            kappaJeff(nb) = -1;        % negative values are given for this
            tau_qJeff(nb) = -1; 
            tau_TJeff(nb) = -1;
            resnJeff(nb) = -1;
            ratioFluxModel = ratioFlux;
            CaseJeff(nb) = 0;        
        end
        plot(hAx2,time,ratioFlux,'-',time,ratioFluxModel,[ls{(mod(3,length(ls))+1)},cs{(mod(3,length(cs))+1)}],'Linewidth', 2); 
    end
    
%% Fourier parameter
    clear p;
    opts = statset('Display','iter','TolFun',1e-10);  
    resnorm1 = 999999;
    
    if (model_flag == 3)
        for i=1:size(gkappa,2)
            p0 = gkappa(i)/gamma;
            [p,resnorm, res, exitflag] = lsqcurvefit(modelFou,p0,time,ratioTheta);
            if ((resnorm < resnorm1) && (exitflag == 3 || exitflag == 1) ) 
                resnorm1 = resnorm;
                pfour = p;
            end
        end
        kappaFou(nb) = pfour*gamma; % in W/mK
        resnFou(nb) = resnorm1/(nprofs-1);
        ratioThetaModel = modelFou(p,time);
        plot(hAx1,time,ratioTheta,'-',time,ratioThetaModel,[ls{(mod(2,length(ls))+1)},cs{(mod(2,length(cs))+1)}],'Linewidth', 2);
    end
end

if (model_flag == 1)
    fout = fopen('paramJeffreys.txt','w');
    
    disp(sprintf('Printing Jeffreys parameters for each block (set)'));
    disp(sprintf('============================================================================'));
    disp(sprintf('Case\t kappa\t\t tau_T\t\t tau_q\t\t residual norm'));
    disp(sprintf('============================================================================'));

    fprintf(fout,'Printing Jeffreys parameters for each block (set)\n');
    fprintf(fout,'============================================================\n');
    fprintf(fout,'Case\t kappa\t\t tau_T\t\t tau_q\t\t residual norm\n');
    fprintf(fout,'============================================================\n');
    
    for nb = 1:nblocks
        disp(sprintf('%d\t %f\t %f\t %f\t %e',CaseJeff(nb),kappaJeff(nb),tau_TJeff(nb),tau_qJeff(nb),resnJeff(nb)));
        fprintf(fout,'%d\t %f\t %f\t %f\t %e\n',CaseJeff(nb),kappaJeff(nb),tau_TJeff(nb),tau_qJeff(nb),resnJeff(nb));
    end
    disp(sprintf('============================================================================'));
    disp(sprintf('Case 1, 2, 3 refers to (lambda_2)^2 > 0, < 0, = 0.\nCase 0 means minimum was not found for the block.'));
    disp(sprintf('============================================================================\n'));
    fprintf(fout,'============================================================\n');
    fprintf(fout,'Case 1, 2, 3 refers to (lambda_2)^2 > 0, < 0, = 0.\nCase 0 means minimum was not found for the block.\n');
    fprintf(fout,'============================================================\n\n');

    % Only non-negative values are selected
    kappa = kappaJeff(kappaJeff >= 0);
    tau_T = tau_TJeff(tau_TJeff >= 0);
    tau_q = tau_qJeff(tau_qJeff >= 0);
    
    mean_kappa = mean(kappa); 
    mean_tau_q = mean(tau_q); 
    mean_tau_T = mean(tau_T); 
    
    std_kappa = std(kappa);
    std_tau_q = std(tau_q);
    std_tau_T = std(tau_T);

    disp(sprintf('Printing final Jeffreys-type parameters:\n\nkappa\t\t std_kappa\t tau_T\t\t std_tau_T\t tau_q\t\t std_tau_q'));
    disp(sprintf('============================================================================================='));
    disp(sprintf('%f\t %f\t %f\t %f\t %f\t %f',mean_kappa,std_kappa,mean_tau_T,std_tau_T,mean_tau_q,std_tau_q));
    disp(sprintf('============================================================================================='));

    fprintf(fout,'Printing final Jeffreys-type parameters:\n\nkappa\t\t std_kappa\t tau_T\t\t std_tau_T\t tau_q\t\t std_tau_q\n');
    fprintf(fout,'=========================================================================\n');
    fprintf(fout,'%f\t %f\t %f\t %f\t %f\t %f\n',mean_kappa,std_kappa,mean_tau_T,std_tau_T,mean_tau_q,std_tau_q);
    fprintf(fout,'=========================================================================\n');
    
    hleg2 = legend(hAx2,'Flux', 'Jeffreys-type Flux Fit');
    set(hleg2,'Location','NorthEast'); 

elseif (model_flag == 2)
    fout = fopen('paramCV.txt','w');
    
    disp(sprintf('Printing CV parameters for each block (set)'));
    disp(sprintf('========================================================='));
    disp(sprintf('Case\t kappa\t\t tau_q\t\t residual norm'));
    disp(sprintf('========================================================='));

    fprintf(fout,'Printing CV parameters for each block (set)\n');
    fprintf(fout,'===========================================\n');
    fprintf(fout,'Case\t kappa\t tau_q\t residual norm\n');
    fprintf(fout,'===========================================\n');

    for nb = 1:nblocks
        fprintf(fout,'%d\t %f\t %f\t %e\n',CaseCV(nb),kappaCV(nb),tau_qCV(nb),resnCV(nb));
        disp(sprintf('%d\t %f\t %f\t %e',CaseCV(nb),kappaCV(nb),tau_qCV(nb),resnCV(nb)));
    end
    disp(sprintf('========================================================='));
    disp(sprintf('Case 1, 2, 3 refers to (lambda_2)^2 > 0, < 0, = 0.\nCase 0 means minimum was not found for the block.'));
    disp(sprintf('=========================================================\n'));
    fprintf(fout,'=================================================\n');
    fprintf(fout,'Case 1, 2, 3 refers to (lambda_2)^2 > 0, < 0, = 0.\nCase 0 means minimum was not found for the block.\n');
    fprintf(fout,'=================================================\n\n');
    
    % Only non-negative values are selected
    kappa = kappaCV(kappaCV >= 0);
    tau_q = tau_qCV(tau_qCV >= 0);

    mean_kappa = mean(kappa); 
    mean_tau_q = mean(tau_q); 

    std_kappa = std(kappa);
    std_tau_q = std(tau_q);

    disp(sprintf('Printing final CV parameters:\n\nkappa\t\t std_kappa\t tau_q\t\t std_tau_q'));
    disp(sprintf('==========================================================='));
    disp(sprintf('%f\t %f\t %f\t %f',mean_kappa,std_kappa,mean_tau_q,std_tau_q));
    disp(sprintf('==========================================================='));

    fprintf(fout,'Printing final CV parameters:\n\nkappa\t\t std_kappa\t tau_q\t\t std_tau_q\n');
    fprintf(fout,'==================================================\n');
    fprintf(fout,'%f\t %f\t %f\t %f\n',mean_kappa,std_kappa,mean_tau_q,std_tau_q);
    fprintf(fout,'==================================================\n');
    
elseif (model_flag == 3)
    fout = fopen('paramFourier.txt','w');

    disp(sprintf('Printing Fourier parameters for each block (set)'));
    disp(sprintf('================================================'));
    disp(sprintf('kappa\t\t residual norm'));
    disp(sprintf('================================================'));

    fprintf(fout,'Printing Fourier parameters for each block (set)\n');
    fprintf(fout,'================================================\n');
    fprintf(fout,'kappa\t\t residual norm\n');
    fprintf(fout,'================================================\n');

    for nb = 1:nblocks
        fprintf(fout,'%f\t %f\n',kappaFou(nb),resnFou(nb));
        disp(sprintf('%f\t %f',kappaFou(nb),resnFou(nb)));
    end
    disp(sprintf('================================================\n'));
    fprintf(fout,'================================================\n\n');

    % Only non-negative values are selected
    kappa = kappaFou(kappaFou >= 0);

    mean_kappa = mean(kappa); 
    
    std_kappa = std(kappa);

    disp(sprintf('Printing final Fourier parameters:\n\nkappa\t\t std_kappa'));
    disp(sprintf('=============================='));
    disp(sprintf('%f\t %f',mean_kappa,std_kappa));
    disp(sprintf('=============================='));
    
    fprintf(fout,'Printing final Fourier parameters:\n\nkappa\t\t std_kappa\n');
    fprintf(fout,'========================\n');
    fprintf(fout,'%f\t %f\n',mean_kappa,std_kappa);
    fprintf(fout,'========================\n');
end

hleg1 = legend(hAx1,'Data', 'Temperature fit');
set(hleg1,'Location','NorthEast');

