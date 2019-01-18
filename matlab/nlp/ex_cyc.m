function [y] = ex_cyc(x,a,b,c)
%
% Example function for multivariate search methods
%
y = a*x(1)*x(1) + b*x(2)*x(2) + c*x(1)*x(2);
