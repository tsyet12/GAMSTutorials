%	Chapter 2: Optimization with Matlab
%  Dr. P.Venkataraman
%  Example 2.3 Sec.2.3
%
%	graphical solution using matlab (two design variables)
%  Optimal design of a Flag Pole for high winds
%  Ref. 2.4
%----------------------------------------------------
% global statement is used to share same information between 
% various m-files
global ELAS SIGALL TAUALL GAM FS GRAV
global RHO CD FLAGW SPEED LP L DELT
%-----------------------------------------------------
% Initialize values
ELAS = 200e+09;   		% Pa
SIGALL = 250E+06; 		% Pa
TAUALL = 145e+06;			%Pa
GAM	= 7860;				% kg/m3
FS = 2.5;					% factor of safety
GRAV = 9.81;				% gravitational acceleration
%-------------------
RHO = 1.225;				% kg/m3
CD = 1.0	;					% drag coefficient
FLAGW = 5000;				% N
SPEED = 156.46	;			% m/s
%-------------------
LP = 8;						% m
L = 10;
DELT = 0.05;				% m
%------------------
g1val = SIGALL/FS	% right hand side values
g2val = TAUALL/FS
g3val = DELT
g4val = 0.001
%-----------------------------------------------------------
x1=0.02:0.01:1;	% the semi-colon at the end prevents the echo 
x2=0.025:0.01:1;	% these are also the side constraints
% x1 and x2 are vectors filled with numbers 
% note a way to avoid x1 = x2
[X1 X2] = meshgrid(x1,x2);
% generates matrices X1 and X2 correspondin
% vectors x1 and x2


f1 = obj_ex3(X1,X2);
% the objecive function is evaluated over the entire mesh

% Constraints are evaluated 
ineq1 = ineq1_ex3(X1,X2);

ineq2 = ineq2_ex3(X1,X2);

ineq3 = ineq3_ex3(X1,X2);

ineq4 = ineq4_ex3(X1,X2);

%contour(x1,x2,f1,10);

[C1,h1] = contour(x1,x2,f1,[0,10000,50000,100000, ...
           150000, 200000, 250000, 300000],'g-');
%   [0 0.1 0.3 0.6 0.8 1.0 1.2 1.5 1.8 2.0 2.2 2.4 2.6 2.8 3.0]);
clabel(C1,h1);
set(gca,'xtick',[0 0.2 0.4 0.6 0.8 1.0])
set(gca,'ytick',[0 0.2 0.4 0.6 0.8 1.0])
xlabel('outside diameter','FontName','times','FontSize',12);
ylabel('inside diameter','FontName','times','FontSize',12)
grid
%hold on

figure
contour(x1,x2,ineq1,[g1val,g1val],'r-');
hold on
contour(x1,x2,ineq1,[0.1*g1val,0.1*g1val],'b-');
set(gca,'xtick',[0 0.2 0.4 0.6 0.8 1.0])
set(gca,'ytick',[0 0.2 0.4 0.6 0.8 1.0])
xlabel('outside diameter','FontName','times','FontSize',12);
ylabel('inside diameter','FontName','times','FontSize',12);
hold off
grid


%[C2,h2] =contour(x1,x2,ineq1,[g1val, 0.1*g1val],'r-');
%clabel(C2,h2);
%set(h2,'LineWidth',1)
%k2 = gtext('g1');
%set(k2,'FontName','Times','FontWeight','bold','FontSize',14,'Color','red')

figure
contour(x1,x2,ineq2,[g2val,g2val],'r-');
hold on
contour(x1,x2,ineq2,[0.1*g2val,0.1*g2val],'b-');
set(gca,'xtick',[0 0.2 0.4 0.6 0.8 1.0])
set(gca,'ytick',[0 0.2 0.4 0.6 0.8 1.0])
xlabel('outside diameter','FontName','times','FontSize',12);
ylabel('inside diameter','FontName','times','FontSize',12);
hold off
grid

%[C3,h3] = contour(x1,x2,ineq2,[g2val,0.1*g2val],'r--');
%clabel(C3,h3);
%set(h3,'LineWidth',1)
%k3 = gtext('g2');
%set(k3,'FontName','Times','FontWeight','bold','FontSize',14,'Color','red')

figure
contour(x1,x2,ineq3,[g3val,g3val],'r-');
hold on
contour(x1,x2,ineq3,[0.1*g3val,0.1*g3val],'b-');
set(gca,'xtick',[0 0.2 0.4 0.6 0.8 1.0])
set(gca,'ytick',[0 0.2 0.4 0.6 0.8 1.0])
xlabel('outside diameter','FontName','times','FontSize',12);
ylabel('inside diameter','FontName','times','FontSize',12);
hold off
grid


%[C4,h4] = contour(x1,x2,ineq3,[g3val,g3val],'b-');
%clabel(C4,h4);
%set(h4,'LineWidth',1)
%k4 = gtext('g3');
%set(k4,'FontName','Times','FontWeight','bold','FontSize',14,'Color','blue')

figure
contour(x1,x2,ineq4,[g4val,g4val],'r-');
hold on
contour(x1,x2,ineq4,[0.001*g4val,0.001*g4val],'b-');
set(gca,'xtick',[0 0.2 0.4 0.6 0.8 1.0])
set(gca,'ytick',[0 0.2 0.4 0.6 0.8 1.0])
xlabel('outside diameter','FontName','times','FontSize',12);
ylabel('inside diameter','FontName','times','FontSize',12);
hold off
grid

%[C5,h5] = contour(x1,x2,ineq4,[g4val,g4val],'b--');
%clabel(C5,h5);
%set(h5,'LineWidth',1)
%k5 = gtext('g4');
%set(k5,'FontName','Times','FontWeight','bold','FontSize',14,'Color','blue')


% the equality and inequality constraints are not written 
% with 0 on the right hand side. If you do write them that way
% you would have to include [0,0] in the contour commands

%xlabel('outside diameter','FontName','times','FontSize',12);	% label for x-axes
%ylabel('inside diameter','FontName','times','FontSize',12);
%title({'Filled Labelled Contour','default color'}, ...
 %  'FontName','times','FontSize',10)
%grid

%hold off

