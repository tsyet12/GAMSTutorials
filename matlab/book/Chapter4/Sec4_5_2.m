% Example 4.3	Flag Pole Problem
%
% Optimzation with MATLAB, Section 4.5.2
% Dr. P.Venkataraman
% Flag Pole Problem (see also Example 2.4)
%
%-------------------------
% symbolic procedure
%------------------------

% constant values
elas = 200e09; sigall=250e06; tauall=145e06;
gamm=7860; fs = 2.5; rho=1.225; cd = 1.0; gac = 9.81;
flagw=5000; wind = 156.46; lp = 8; l = 10; defl = 0.05;

% define symbolic variables
% unscaled solution
format compact
syms area inet qt
syms fd mw sigbend sigweight st tau 
syms delw delf
syms x1 x2 b1 b2 b3 b4 g1 g2 g3 g4 f F 
area= 0.25*pi*(x1*x1-x2*x2);
inet =pi*(x1^4 - x2^4)/64;
qt = (x1*x1 + x1*x2 + x2*x2)/6;

fd = 0.5*rho*wind*wind*cd*x1;
mw = 0.5*fd*l*l;
mf = flagw*lp;
sigbend = 0.5*(mw + mf)*x1/inet;
sigweight = gamm* gac*l;

g1 = sigbend + sigweight -(sigall/fs);

st = flagw + fd*l;
tau = st *qt/inet;
g2 = tau - tauall/fs;

delw = fd*l^4/(8*elas*inet);
delf  = (2*flagw*l^3 -flagw*l*l*lp)/(elas*inet);
g3 = delw + delf -defl;

g4 = x2 - x1 + 0.001;

%Based on the graphical solution g1 and g3 are active
[xs1 xs2] = solve(g1,g3,'x1,x2');
% multiple solutions are expected

% Since g2 and g4 are inactive the multipliers 
% b2 and b4 are zero
% still need to calculate b1 and b3

% define Lagrangian F 
f = x1^2 - x2^2;

% optimal values
% satisfaction of Kuhn Tucker conditions

%double(xs1),double(xs2)   % values of x1 an x2
F = f + b1*g1+ b2*g2 + b3*g3 +b4*g4;


%the gradient of F
syms grad1 grad2
grad1 = diff(F,x1);
grad2 = diff(F,x2);
	 
%
% case b2 = 0 , b4 = 0 g1 = 0, g3 = 0
b2= 0; b4 = 0;

% the following information is obtained after 
% scanning xs1 and xs2 and locating values
% that apply at the index value of 8
% to save programming the code is run twice

x1=double(xs1(8));
fprintf('\n x1 = '),disp(x1)
x2=double(xs2(8));
fprintf('\n x2 = '),disp(x2)

fprintf('\nConstraint:')
fprintf('\ng1:  '),disp(subs(g1))
fprintf('\ng2:  '),disp(subs(g2))
fprintf('\ng3:  '),disp(subs(g3))
fprintf('\ng4:  '),disp(subs(g4))

[bs1 bs3]=solve(subs(grad1),subs(grad2),'b1,b3');

fprintf('Multipliers b1 and b3  : ')
fprintf('\nb1:  '),disp(double(bs1))
fprintf('\nb2:  '),disp(double(bs3))
