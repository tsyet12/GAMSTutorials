% Example 10.1: Linear Programming
% Chapter 10: Optimization Toolbox%
% Applied Optimization with MATLAB
% P.Venkataraman
% Published by John Wiley
%
% NOTE: you don not need to use the same variable names
%
format compact
f = [-4 -6 -7 -8];
A = [2 3 4 7; 3 4 5 6; 0 0 0 -1];
b=[4600 5000 -400];
Aeq = [1 1 1 1];
beq = [950];
LB = [0 0 0 0];
UB = [inf inf inf inf];

[X,FVAL,EXITFLAG] = LINPROG(f,A,b,Aeq,beq,LB,UB)
