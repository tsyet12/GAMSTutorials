% Applied Optimization with MATLAB
% P.Venkataraman
% Published by John Wiley
% Chapter 10: Optimization Toolbox from MATLAB
% Section 10.2.2 Quadratic programming
% Example 10.2: 
%----------------------------------------------
clear
clc
format compact
warning off

c = [-1 -2 -3];
H = [3 -1  1; -1 2 1;1 1 4];
A = [1 2 -1];
B = [2.5];
Aeq =[2 -1 3];
Beq = [1];
LB=[0 0 0];

[x,fval,EXITFLAG,OUTPUT,lambda] = quadprog(H,c,A,B,Aeq,Beq,LB,[]);
g1 = A*x;
g2 = Aeq*x;
fprintf('\nFinal Values\n')
fprintf('Optimum Design Variables\n')
fprintf('-------------------------\n'),disp(x')
fprintf('Optimum function value\n')
fprintf('----------------------\n'),disp(fval)
fprintf('\nLagrange Multipliers for inequality constraint\n')
fprintf('------------------------------------------------\n')...
   ,disp(lambda.ineqlin')
fprintf('\nInequality constraint\n')
fprintf('-----------------------\n'),disp(g1)
fprintf('\nLagrange Multipliers for equality constraint\n')
fprintf('------------------------------------------------\n')...
   ,disp(lambda.eqlin')
fprintf('\nEquality constraint\n')
fprintf('----------------------\n'),disp(g2)
