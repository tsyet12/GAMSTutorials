%  Applied Optimization with MATLAB
%  Dr. P.Venkataraman
%  Chapter 7, Section 7.4.2
%  Sequential Quadratic Prgramming
%  Example 7.3
%  
% The input is the current design vector
% The output to the Command Window is the result of
% applying the KT conditions analytically
% to the QP subproblem. Results for 2 casea
% Case (a) : beta = 0 g < 0
% Case (b) : beta ~= 0, g = 0
% select the right one and rerun the program
% (after all this is a Sequential program)
%
format compact
format short e

%**********************
% Program Constants
%**********************
W = 2000; L = 96; E = 29e+06; rho = 0.284;
sigy = 36e+03; tauy = 21e+03; del = 0.25; FOS = 1.4;

%****************************************************************
%*  define analytical functions
%*	 
%**************************************************************
syms x1 x2 x3 x4
syms f gradx1 gradx2 gradx3 gradx4
syms x1d x2d x3d x4d hess
syms g1 g1x1 g1x2 g1x3 g1x4
syms g2 g2x1 g2x2 g2x3 g2x4
syms g3 g3x1 g3x2 g3x3 g3x4
syms g4 g4x1 g4x2 g4x3 g4x4
syms g5 g5x1 g5x2 g5x3 g5x4
syms g6 g6x1 g6x2 g6x3 g6x4
syms g7 g7x1 g7x2 g7x3 g7x4
syms ac in qc
% the in between calculations
ac = 2*x2*x4+x1*x3-2*x3*x4;
in = (x2*x1^3/12)-((x2-x4)*(x1 -2*x3)^3/12);
qc = 0.5*x2*x4*(x1-x4)+0.5*x3*(x1-x4)^2;

% objective function
f = rho*L*ac;

% constraints
g1 = W*L^3 -12*E*in;
g2 = W*L*x1 - 8*in*sigy;
g3 = W*qc - 2*in*x3*tauy;
g4 = x1 - 3*x2;
g5 = 2*x2 - x1;
g6 = x3 -1.5*x4;
g7 = 0.5*x4 - x3;

G = [g1 g2 g3 g4 g5 g5 g7];


%*****************************************************************
%  input the design vector
% enter the value for design vector scanned from command window
string1 = ['Input the design vector chosen for evaluation.\n'] ;
xs = input(string1);
fprintf('\nThe design vector [ %10.4f  %10.4f \n]',xs);
%********************************************************

% the gradients of the objective
gradx1 = diff(f,x1);
gradx2 = diff(f,x2);
gradx3 = diff(f,x3);
gradx4 = diff(f,x4);
% gradients of the constraints
g1x1 = diff(g1,x1);
g1x2 = diff(g1,x2);
g1x3 = diff(g1,x3);
g1x4 = diff(g1,x4);

g2x1 = diff(g2,x1);
g2x2 = diff(g2,x2);
g2x3 = diff(g2,x3);
g2x4 = diff(g2,x4);

g1x1 = diff(g3,x1);
g3x2 = diff(g3,x2);
g3x3 = diff(g3,x3);
g3x4 = diff(g3,x4);

g4x1 = diff(g4,x1);
g4x2 = diff(g4,x2);
g4x3 = diff(g4,x3);
g4x4 = diff(g4,x4);

g5x1 = diff(g5,x1);
g5x2 = diff(g5,x2);
g5x3 = diff(g5,x3);
g5x4 = diff(g5,x4);

g6x1 = diff(g6,x1);
g6x2 = diff(g6,x2);
g6x3 = diff(g6,x3);
g6x4 = diff(g6,x4);

g7x1 = diff(g7,x1);
g7x2 = diff(g7,x2);
g7x3 = diff(g7,x3);
g7x4 = diff(g7,x4);

Gx1 = diff(G,x1);
Gx2 = diff(G,x2);
Gx3 = 






hx1 = diff(h,x1);
hx2 = diff(h,x2);

% the hessian
hess = [diff(gradx1,x1), diff(gradx1,x2); diff(gradx2,x1), diff(gradx2,x2)];

% evaluate the function, gradients , and hessian at the current design
fv = double(subs(f,{x1,x2},{xs(1),xs(2)}))
hv = double(subs(h,{x1,x2},{xs(1),xs(2)}))
gv = double(subs(g,{x1,x2},{xs(1),xs(2)}))
dfx1 = double(subs(gradx1,{x1,x2},{xs(1),xs(2)}))
dfx2 = double(subs(gradx2,{x1,x2},{xs(1),xs(2)}))
dgx1 = double(subs(gx1,{x1,x2},{xs(1),xs(2)}))
dgx2 = double(subs(gx2,{x1,x2},{xs(1),xs(2)}))
dhx1 = double(subs(hx1,{x1,x2},{xs(1),xs(2)}))
dhx2 = double(subs(hx2,{x1,x2},{xs(1),xs(2)}))
hessv = double(subs(hess,{x1,x2},{xs(1),xs(2)}))

% the QP subproblem
syms fquad glin hlin dx1 dx2
fquad = fv + [dfx1 dfx2]*[dx1; dx2] + 0.5*[dx1 dx2]*hessv*[dx1 ;dx2];
hlin = hv + [dhx1 dhx2]*[dx1; dx2];
glin = gv + [dgx1 dgx2]*[dx1; dx2];

% define Lagrangian for the QP problem
syms F lamda beta
F = fquad + lamda*hlin + beta*glin;

fprintf('\n Case a: beta = 0\n')
Fnobeta = fquad + lamda*hlin;

xcasea = solve(diff(Fnobeta,dx1),diff(Fnobeta,dx2),hlin);
sola = [double(xcasea.dx1) double(xcasea.dx2) double(xcasea.lamda)]
dx1a = double(xcasea.dx1)
dx2a = double(xcasea.dx2)
hlina = double(subs(hlin,{dx1,dx2},{dx1a,dx2a}))
glina = double(subs(glin,{dx1,dx2},{dx1a,dx2a}))

x1a = dx1a + xs(1)
x2a = dx2a + xs(2)
fv = double(subs(f,{x1,x2},{x1a,x2a}))
hv = double(subs(h,{x1,x2},{x1a,x2a}))
gv = double(subs(g,{x1,x2},{x1a,x2a}))


fprintf('\n Case b: beta = 0\n')
xcaseb = solve(diff(F,dx1),diff(F,dx2),hlin,glin);
solb = [double(xcaseb.dx1) double(xcaseb.dx2) double(xcaseb.lamda) double(xcaseb.beta)]
dx1b = double(xcaseb.dx1)
dx2b = double(xcaseb.dx2)
hlinb = double(subs(hlin,{dx1,dx2},{dx1b,dx2b}))
glinb = double(subs(glin,{dx1,dx2},{dx1b,dx2b}))

x1b = dx1b + xs(1)
x2b = dx2b + xs(2)
fv = double(subs(f,{x1,x2},{x1b,x2b}))
hv = double(subs(h,{x1,x2},{x1b,x2b}))
gv = double(subs(g,{x1,x2},{x1b,x2b}))

%Fnobeta = fquad + lamda*hlin

%xcasea = solve(diff(Fnobeta,dx1),diff(Fnobeta,dx2),hlin);
%sola = [double(xcasea.dx1) double(xcasea.dx2) double(xcasea.lamda)]
