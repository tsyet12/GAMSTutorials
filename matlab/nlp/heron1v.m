function [dist] = heron1v(c1,a1,a2,b1,b2,a,b)
%
% returns the total distance from the points 
% A=(a1 a2) and B=(b1 b2) to the point C=(c1 c2)
% where C is on the line given by: c2 = a*c1 + b
%
dist=((c1-a1).^2 + (a.*c1+b - a2).^2).^0.5 + ((c1-b1).^2 + (a.*c1+b - b2).^2).^0.5;
