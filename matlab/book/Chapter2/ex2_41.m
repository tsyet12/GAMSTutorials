%	Chapter 2: Optimization with Matlab
%  Dr. P.Venkataraman
%  Example 2.4 Sec.2.3
%
%	graphical solution using matlab (two design variables)
%  Minimum fin volume for efficient heat transfer
%  material Aluminum
%----------------------------------------------------
% global statement is used to share same information between 
% various m-files
global N H K W AREA 
%-----------------------------------------------------
% Initialize values  
N = 20						% number of fins
W = 0.1						% width of fins
H = 50.0	% convection coefficient W/m*m
K = 177.0	% thermal conductivity W/m-K
AREA = 0.015 % available fin foot print area 
%-----------------------------------------------------------
% right hand limits for the functions
h1val = AREA;
g1val = 0.95;
g2val = 0.94;
%---------------------------------------------------------
x1=0.001:0.0001:0.005;	 
x2=0.01:0.001:0.06;% x1 and x2 are vectors filled with numbers 
[X1 X2] = meshgrid(x1,x2);
% generates matrices X1 and X2 corresponding to
% vectors x1 and x2


f1 = obj_ex4(X1,X2);
% the objecive function is evaluated over the entire mesh

% Constraints are evaluated 
eq1 = eq1_ex4(X1,X2);

[ineq1, ineq2]  = ineq_ex4(X1,X2);


%[C2,h2] =contour(x1,x2,ineq1,[g1val, 0.1*g1val],'r-');
%clabel(C2,h2);
%set(h2,'LineWidth',1)
%k2 = gtext('g1');
%set(k2,'FontName','Times','FontWeight','bold','FontSize',14,'Color','red')


[C1,h1] = contour(x1,x2,f1,[0.00006, 0.0001, ...
      0.00012, 0.00014, 0.00016, 0.0002],'g-');
clabel(C1,h1);
set(gca,'xtick',[0.001 0.0015 0.002 0.0025 0.003 0.0035 ...
      0.004 0.0045 0.005])
set(gca,'ytick',[0.015 0.025 ...
   0.035 0.045 0.055 0.06]);
xlabel('fin base(m)','FontName','times','FontSize',12);
ylabel('fin length(m)','FontName','times','FontSize',12)
grid
hold on


[C2,h2]=contour(x1,x2,eq1,[h1val,h1val],'r--');
clabel(C2,h2);
set(h2,'LineWidth',2)
k2 = gtext('h1');
set(k2,'FontName','Times','FontWeight','bold','FontSize',14,'Color','red')

grid


[C3,h3]=contour(x1,x2,ineq1,[g1val,g1val],'b-');
clabel(C3,h3);
set(h3,'LineWidth',2)
k3 = gtext('g1');
set(k3,'FontName','Times','FontWeight','bold','FontSize',14,'Color','blue')
grid


[C4,h4]=contour(x1,x2,ineq2,[g2val,g2val],'b-');
clabel(C4,h4);
set(h4,'LineWidth',2)
k4 = gtext('g2');
set(k4,'FontName','Times','FontWeight','bold','FontSize',14,'Color','blue')
grid
hold off
grid
