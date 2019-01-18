function [f2] = testf2(x,y,c1,c2,a,b,c)
% (c) jskl 2002
% general quadratic function, zero at (c1,c2)
%
f2 = a*(x-c1).^2 + b*(y - c2).^2 + c*(x-c1).*(y-c2);

