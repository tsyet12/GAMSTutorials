% Necessary/Sufficient coonditions for 
% Equality constrained problem 
%
% Optimzation with MATLAB, Section 4.4.2
%  Dr. P.Venkataraman
%
%  Minimize f(x1,x2) = -x1
%
%-------------------------
% symbolic procedure
%------------------------
% define symbolic variables
format compact
syms x1 x2 lam1 h1 F 

% define F
F = -x1*x2 + lam1*(x1*x1/4 + x2*x2 -1);
h1 = x1*x1/4 +x2*x2 -1;

%the gradient of F
sym grad;
grad1 = diff(F,x1);
grad2 = diff(F,x2);

% optimal values
% satisfaction of necessary conditions
[lams1 xs1 xs2] = solve(grad1,grad2,h1,'x1,x2,lam1');


% the solution is returned as a vectot of
% the three unknowns in case of multiple solutions
% lams1  is the solution vector for lam1 etc.
% IMPORTANT: the results are sorted alphabetically
% 
% fprint is used to print a string in the 
% command window
% disp is used to print values of matrix

f = -xs1.*xs2;
fprintf('The solution (x1*,x2*,lam1*, f*):\n'), ...
   disp(double([xs1 xs2 lams1 f]))

%------------------------------
% Numerical procedure
%----------------------------
% solution to non-linear system using fsolve
% see help fsolve
%
% the unknowns have to be defined as a vector
% the functions have to be set up in a m-file

% define intial values
xinit=[1 1 0.5]'; % inital guess for x1, x2, lam1

% the equations to be solved are available in 
% eqns4_4_2.m

xfinal = fsolve('eqns4_4_2',xinit);

fprintf('The numerical solution (x1*,x2*,lam1*): \n'), ...
	disp(xfinal);
