%**********************************************************
%Nonlinear Least Squares
%**********************************************************
function NLLS
warning off
 clc
 load ZnS_BM.dat
 r = ZnS_BM(:,:);
 
 P = r(:,1)
 V = r(:,2)
 
BM = LS(P,V);
%**********************************************************
% Convert from bars to Pa
%**********************************************************
BM_Pa = BM * 10^5
%**********************************************************
% Convert from Pa to GPa
%**********************************************************
 BM_GPa = BM_Pa * 10^-9 
 s = sprintf('ZnS Bulk Modulaus = %s GPa',BM_GPa)
 
 plot(P,V,'k','LineWidth',5,'MarkerSize',10)
 
 xlabel('Pressure / 
(GPa)','fontweight','bold','fontsize',15)
 ylabel('Volume / (angst 
cubed)','fontweight','bold','fontsize',15)
 legend(s)
 
set(gca,'fontweight','bold',"linewidth",3,'fontsize',25)
 box on
 set(gca,'fontweight','bold','linewidth',3)
 set(gca,'fontsize',18)
 
end
%**********************************************************
% Calculate Q Matrix
%**********************************************************
function Q = Qm(c,v)
 n = length(v);
 for i=1:n 
 Q(i,1) = v(i)*v(i); 
 Q(i,2) = v(i); 
 Q(i,3) = 1.0;
 end
end
%**********************************************************
% Calculate r Vector
%**********************************************************
function r = rv(v,p,c)
 n = length(v);
 r = zeros(n,1);
 for i = 1:n
 r(i) = p(i)-(c(1)*v(i)*v(i)+c(2)*v(i)+c(3)); 
 end
end
%**********************************************************
% Calculate bulk modulus value
%**********************************************************
function B_Ave = LS(p,v)
 c = [1;1;1];
 dc = 2*c;
 while (dc' * dc) > 10^-7
 Q = Qm(c,v);
 r = rv(v,p,c);
 dc = (Q'*Q)\(Q'*r);
 c = c + dc;
 fprintf('%f\t\t%f\t%f\n',c(1),c(2),c(3))
 end
 fprintf('\n P V B\n')
 n = length(v);
 for i = 1:n
 B(i) = -v(i)*(2*c(1)*v(i)+c(2));
 fprintf('%f\t\t%f\t\t%f\n',p(i),v(i),B(i))
 end
 B_Ave = sum(B)/n
end