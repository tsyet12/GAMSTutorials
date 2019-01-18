% Necessary/Sufficient coonditions for 
% Unconstrained problem 
%
% Optimzation with MATLAB, Section 4.4.1
%  Dr. P.Venkataraman
%
%  Minimize f(x1,x2) = (x1-1)^2 +  (x2 - 1)^2 -x1 x2
%

% define symbolic variables
format compact
syms x1 x2 f

% define f
f = (x1-1)^2 +(x2-1)^2 -x1*x2;

%the gradient
sym grad;
grad1 = diff(f,x1);
grad2 = diff(f,x2);
grad =[grad1; grad2];

% the Hessian

% optimal values
% satisfaction of necessary conditions
[xs1 xs2] = solve(grad1,grad2,'x1','x2');

% fprint is used to print a string in the command window
% disp is used to print values of matrix
fprintf('The solution (x1*,x2*): '),disp([xs1 xs2])


% sufficient conditions
sym hessian;
hessian=[diff(grad1,x1) diff(grad1,x2); ...
      diff(grad2,x1) diff(grad2,x2)];
fprintf('\nThe Hessian at (x1*,x2*)\n')
disp(hessian)

% eigenvalues of a square matrix
evalue = eig(hessian);

fprintf('\n\nThe eigenvalues of the Hessian\n')
disp(evalue')
% if eigenvalues are positive then a minimum exists


