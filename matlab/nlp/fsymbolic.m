function [z] = fsymbolic(x,y)
%
% (c) jskl 2003
% Example function for symbolic computations
% f(x,y) = 4x^2 + 3x + 5y^2 - 4y + 20xy - 5
%
z = 4*x^2 + 3*x + 5*y^2 - 4*y + 20*x*y - 5;

