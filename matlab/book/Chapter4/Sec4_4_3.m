% Necessary/Sufficient coonditions for 
% Inequality constrained problem 
%
% Optimzation with MATLAB, Section 4.4.3
%  Dr. P.Venkataraman
%
%  Minimize f(x1,x2) = -x1*x2
%	Subject to:
%	g1:  20*x1 + 15*x2 -30 <=0
%  g2:  0.25x1^2  + x2^2 -1 <=0
%
%	Lagrangian: f + b1*g1 + b2*g2
%
%-------------------------
% symbolic procedure
%------------------------
% define symbolic variables
format compact
syms x1 x2 b1 b2 g1 g2 f F 

% case (a)
% define F 
f = -x1*x2;
g1 = 20*x1 + 15*x2 -30 ;
g2 = 0.25*x1*x1 +x2*x2 - 1;
F = -x1*x2 + b1*g1+ b2*g2;


%the gradient of F
syms grad1 grad2 eq1 eq2
grad1 = diff(F,x1);
grad2 = diff(F,x2);
% optimal values
% satisfaction of necessary conditions
%

b1 = 0; b2 = 0;
% the command subs(...) will substitute for
% those variables whose values are available 
% in the work place
[xs1 xs2] = solve(subs(grad1),subs(grad2),'x1,x2');


% the solution is returned as a vectot of
% the three unknowns in case of multiple solutions
% lams1  is the solution vector for lam1 etc.
% IMPORTANT: the results are sorted alphabetically
% 
% fprint is used to print a string in the 
% command window
% disp is used to print values of matrix

fs = -xs1.*xs2;
gs1= 20*xs1 + 15*xs2 -30 ;
gs2 = 0.25*xs1.*xs1 +xs2.*xs2 - 1;
fprintf('The solution *** Case a ***(x1*,x2*, f*, g1, g2):\n'), ...
   disp(double([xs1 xs2 fs gs1 gs2]))
%------------------------------
% case (b)

% the command subs(...) will substitute for
% those variables whose values are available 
% in the work place
[bs2 xs1 xs2] = solve(subs(grad1,'b1',0),subs(grad2,'b1',0),g2,'x1,x2,b2');

% the solution is returned as a vectot of
% the three unknowns in case of multiple solutions
% lams1  is the solution vector for lam1 etc.
% IMPORTANT: the results are sorted alphabetically
% 
% fprint is used to print a string in the 
% command window
% disp is used to print values of matrix

fs = -xs1.*xs2;
gs1= 20*xs1 + 15*xs2 -30 ;
gs2 = 0.25*xs1.*xs1 +xs2.*xs2 - 1;
fprintf('The solution ***Case (b)*** (x1*,x2*, b2* f*, g1, g2):\n'), ...
         disp(double([xs1 xs2 bs2 fs gs1 gs2]))
%------------------------------
% case (c)

% the command subs(...) will substitute for
% those variables whose values are available 
% in the work place
[bs1 xs1 xs2] = solve(subs(grad1,'b2',0),subs(grad2,'b2',0),g1,'x1,x2,b1');


% the solution is returned as a vectot of
% the three unknowns in case of multiple solutions
% lams1  is the solution vector for lam1 etc.
% IMPORTANT: the results are sorted alphabetically
% 
% fprint is used to print a string in the 
% command window
% disp is used to print values of matrix

fs = -xs1.*xs2;
gs1= 20*xs1 + 15*xs2 -30 ;
gs2 = 0.25*xs1.*xs1 +xs2.*xs2 - 1;
fprintf('The solution ***Case (c)*** (x1*,x2*, b1* f*, g1, g2):\n'), ...
         disp(double([xs1 xs2 bs1 fs gs1 gs2]))

%------------------------------
% case (d)
[bs1 bs2 xs1 xs2] = solve(grad1,grad2,g1,g2,'x1,x2,b1,b2');


% the solution is returned as a vectot of
% the three unknowns in case of multiple solutions
% lams1  is the solution vector for lam1 etc.
% IMPORTANT: the results are sorted alphabetically
% 
% fprint is used to print a string in the 
% command window
% disp is used to print values of matrix

fs = -xs1.*xs2;
gs1= 20*xs1 + 15*xs2 -30 ;
gs2 = 0.25*xs1.*xs1 +xs2.*xs2 - 1;
fprintf('The solution ***Case (d)*** (x1*,x2*, b1*  b2* f*, g1, g2):\n'), ...
         disp(double([xs1 xs2 bs1 bs2 fs gs1 gs2]))



%------------------------------
% Numerical procedure - Case(d) only
%----------------------------
% solution to non-linear system using fsolve
% see help fsolve
%
% the unknowns have to be defined as a vector
% the functions have to be set up in a m-file

% define intial values
warning off
xinit=[1 1 0 0]'; % inital guess for x1, x2, b1, b2

% the equations to be solved are available in 
% eqns4_4_3.m

xfinal = fsolve('eqns4_4_3',xinit);

fprintf('The numerical solution (x1*,x2*,b1*,b2*): \n'), ...
	disp(xfinal');
% Draw the figure for the problem
Fig4_8