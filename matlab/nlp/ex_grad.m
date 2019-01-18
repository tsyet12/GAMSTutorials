function [y] = ex_grad(x,a,b,c)
%
% Example function for gradient search
%
y = a*x(1)*x(1) + b*x(2)*x(2) + c*x(1)*x(2);
