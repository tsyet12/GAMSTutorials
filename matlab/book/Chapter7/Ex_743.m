%  Applied Optimization with MATLAB
%  Dr. P.Venkataraman
%  Chapter 7, Section 7.4.2
%  Sequential Quadratic Prgramming
%  Example 7.3  (please consult text for problem definition)
%  
% The input is the start design vector
% The output is the design and function values
% Iterations stop if no progress s being made to
% improve design changes or the quadratic objective
%
format compact
format short e
clear
clc
%**********************
% Program Constants
%**********************
W = 2000; L = 96; E = 29e+06; rho = 0.284;
sigy = 36e+03; tauy = 21e+03; del = 0.25; fos = 1.4;

%****************************************************************
%*  define analytical functions
%*	 
%**************************************************************
syms x1 x2 x3 x4
%****************************************
% the following definitions are not necessary 
% as they are automatic but they are good coding practice
syms f gradx1 gradx2 gradx3 gradx4 hess
syms g1 g2 g3 g4 g5 g6 g7 
syms g8 g9 g10 g11 g12 g13 g14 g15
syms ac in qc
%*******************************
% the in between calculations
ac = 2*x2*x4+x1*x3-2*x3*x4;
in = (x2*x1^3/12)-((x2-x4)*(x1 -2*x3)^3/12);
qc = 0.5*x2*x4*(x1-x4)+0.5*x3*(x1-x4)^2;

% objective function
f = rho*L*ac;

% constraints
g1 = fos*W*L^3 -12*E*in -0.25;      % deflection    
g2 = fos*W*L*x1 - 8*in*sigy;	% normal stress
g3 = fos*W*qc - 2*in*x3*tauy;   % deflection
g4 = x1 - 3*x2;
g5 = 2*x2 - x1;
g6 = x3 -1.5*x4;
g7 = 0.5*x4 - x3;
g8 = -x1 + 3;        
g9 = -x2 + 2;
g10 = -x3 + 0.125;
g11 = -x4 + 0.25;
g12 = x1 - 20;
g13 = x2 - 15;
g14 = x3 - 0.75;
g15 = x4 -1.25;

G = [g1 g2 g3 g4 g5 g6 g7 g8 g9 g10 g11 g12 g13 g14 g15];

%*****************************************************************
%  input the design vector
% enter the value for design vector scanned from command window
string1 = ['Input the design vector chosen for evaluation.\n'] ;
xs = input(string1);
fprintf('\nStarting  design vector[%8.3f %8.3f %8.3f %8.3f ]\n',xs);

%********************************************************
for i = 1:10
   
% the gradients of the objective
gradx1 = diff(f,x1);
gradx2 = diff(f,x2);
gradx3 = diff(f,x3);
gradx4 = diff(f,x4);

% gradients of the constraints
Gx1 = diff(G,x1);
Gx2 = diff(G,x2);
Gx3 = diff(G,x3);
Gx4 = diff(G,x4);

% The Jacobian of the gradient vector
Ja = [Gx1' Gx2' Gx3' Gx4'];

% gradient vector of the objective
Fd = [gradx1 gradx2 gradx3 gradx4];

% Hessian
hess= [diff(Fd,x1); diff(Fd,x2); diff(Fd,x3); diff(Fd,x4)];

% transfer values for substitution
xd1 = xs(1);xd2 = xs(2); xd3 = xs(3); xd4 = xs(4);

% substitute the values fr x1,x2,x3,x4
fv = double(subs(f,{x1,x2,x3,x4},{xd1, xd2, xd3, xd4}));
gd = double(subs(Fd,{x1,x2,x3,x4},{xd1, xd2, xd3, xd4}));
b = double(subs(G,{x1,x2,x3,x4},{xd1, xd2, xd3, xd4}));
H = double(subs(hess,{x1,x2,x3,x4},{xd1, xd2, xd3, xd4}));
A =double(subs(Ja,{x1,x2,x3,x4},{xd1, xd2, xd3, xd4}));

% Call QP - X is the change in design - see -- help qp
[X] = qp(H,gd,A,-b');

% print design changes - output from qp
fprintf('\nDesign changes[%8.3f %8.3f %8.3f %8.3f ]\n',X');

xs = X' + xs; % update design
ff(i) = gd*X + 0.5*X'*H*X;
dx(i) = sqrt(X'*X);

if i >1
   if abs(ff(i)-ff(i-1)) < 1.0e-08  % check if objective is changing
      fprintf('\nNo change in objective - exiting - iteraion number '),disp(i)
      break
   end
   if dx(i) < 1.0e-08   % check if design is changing
      fprintf('\nNo chandge in design - exiting - iteraion number '),disp(i)
      break
   end
end

%clear gradx1 gradx2 gradx3 gradx4
%clear Gx1 Gx2 Gx3 Gx4
%clear Ja Fd fv gd b H A

end

% Calculate values for final printing
fprintf('\nFinal Design [%8.3f %8.3f %8.3f %8.3f ]\n',xs);
xd1 = xs(1);xd2 = xs(2); xd3 = xs(3); xd4 = xs(4);

fv = double(subs(f,{x1,x2,x3,x4},{xd1, xd2, xd3, xd4}));
fprintf('\nObjective Function: %8.3f (weight)\n',fv);

b = double(subs(G,{x1,x2,x3,x4},{xd1, xd2, xd3, xd4}));
fprintf('\nConstraints g1 -> g15 ;\n'),disp(b)

H = double(subs(hess,{x1,x2,x3,x4},{xd1, xd2, xd3, xd4}));
A =double(subs(Ja,{x1,x2,x3,x4},{xd1, xd2, xd3, xd4}));
