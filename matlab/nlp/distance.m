function [dist] = distance(a1,a2,b1,b2,a,b,c,c1)
% distance(a1,a2,b1,b2,a,b,c,c1) returns the total distance
% from the points A=(a1 a2) and B=(b1 b2) to the point C=(c1 c2)
% where c2 = a*c1^2 + b*c1 + c
dist=((c1-a1)^2 + (a*c1*c1+b*c1+c - a2)^2)^0.5 + ((c1-b1)^2 + (a*c1*c1+b*c1+c - b2)^2)^0.5;
