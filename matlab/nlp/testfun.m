function [d] = testfun(x,y,c1,c2)
%
% distance0(c1) returns the total distance
% from the points A=(a1 a2) and B=(b1 b2) to the point C=(c1 c2)
% where c2 = a*c1^2 + b*c1 + c
%
d = ((x-c1)^2 + (y - c2)^2);

