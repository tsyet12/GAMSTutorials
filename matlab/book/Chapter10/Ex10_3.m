% Applied Optimization with MATLAB
% P.Venkataraman
% Published by John Wiley
% Chapter 10: Optimization Toolbox from MATLAB
% Section 10.2.3 Constrained Optimization
% Example 10.3: 
%----------------------------------------------
clear
clc
format compact
warning off
global t yc
t = 0:0.01:1;
yc = cos(t);
x = [1 1 1];
options = optimset('LargeScale','off','Display','final', ...
   'TolFun',1.0e-08,'GradObj','on');

[x,fval,EXITFLAG,OUTPUT,grad] = fminunc('obj10_3',x,options);
%EXITFLAG
%OUTPUT
fprintf('\nFinal Values - User specified Gradients\n')
fprintf('Optimum Design Variables\n')
fprintf('-------------------------\n'),disp(x)
fprintf('\nOptimum function value\n')
fprintf('----------------------\n'),disp(fval)
fprintf('\nGradients of the function\n')
fprintf('------------------------------\n'),disp(grad')

options = optimset('LargeScale','off','Display','iter', ...
   'TolFun',1.0e-08);

xng = [1 1 1];
[xng,fng,EXITFLAG,OUTPUT,gradng] = fminunc('obj10_3',xng);
fprintf('\nFinal Values - Default Finite Difference Gradients\n')
fprintf('Optimum Design Variables\n')
fprintf('-------------------------\n'),disp(xng)
fprintf('\nOptimum function value\n')
fprintf('----------------------\n'),disp(fng)
fprintf('\nGradients of the function\n')
fprintf('------------------------------\n'),disp(gradng')

plot(t,yc,'r')
hold on
plot(t,x(1)*t.^2+x(2)*t+x(3),'b')
plot(t,xng(1)*t.^2+xng(2)*t+xng(3),'k')
xlabel('t')
ylabel('y')
title('Curve fitting cos(t) with a quadratic')
legend('Original data','Fit with User Supplied Gradients','Fit-Default Finite Difference Gradients')
grid
hold off