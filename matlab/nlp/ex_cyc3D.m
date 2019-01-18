function [y] = ex_cyc3D(x,a,b,c)
%
% Example function for cyclic co-ordinate search
%
y = a*x(1)*x(1) + b*x(2)*x(2) + c*x(3)*x(3) - x(1)*x(2)*x(3);
