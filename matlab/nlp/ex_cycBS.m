function [y] = ex_cycBS(x)
%
% Example function B&S, xmin = [2 1], f(xmin) = 0
%
y = (x(1) - 2)^4 + (x(1) - 2*x(2))^2;