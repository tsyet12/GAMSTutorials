% Applied Optimization with MATLAB
% P.Venkataraman
% Published by John Wiley
% Chapter 10: Optimization Toolbox from MATLAB
% Section 10.2.4 Constrained Optimization
% Example 10.4: 
%----------------------------------------------
global rho L W E sigy tauy
format compact

% set data
rho = 0.284;
L = 96;
W = 1.4*2000;
E = 29e06;
sigy = 36e+03;
tauy = 21e+03;

LB = [3 2 0.125 0.25];
UB = [20 15 0.75 1.25];
x0 = [10 4 0.3 0.75];

A = [1 -3 0 0 ; -1 2 0 0 ; 0 0 1 -1.5; 0 0 -1 0.5];
B = [0 0 0 0];

options = optimset('LargeScale','off','Display','iter', ...
   'TolFun',1.0e-08);
[x, fval, exitflag, output, lambda] = ...
   fmincon('objective',x0,A,B,[],[],LB,UB,'nonlin_cons',options);

fprintf('\nFinal Values\n')
fprintf('Optimum Design Variables\n')
fprintf('-------------------------\n'),disp(x)
fprintf('\nOptimum function value\n')
fprintf('----------------------\n'),disp(fval)

gcon = nonlin_cons(x);
fprintf('\nFinal Nonlinear Constraints\n')
fprintf('------------------------------\n'),disp(gcon)

fprintf('\nLagrange Multipliers for Nonlinear constraints\n')
fprintf('------------------------------------------------\n')...
   ,disp(lambda.ineqnonlin')

fprintf('\nLagrange Multipliers for Linear constraints\n')
fprintf('------------------------------------------------\n')...
   ,disp(lambda.ineqlin')





