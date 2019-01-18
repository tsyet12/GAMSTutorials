function [dist] = heron2(x1,a1,a2,b1,b2,a,b,c)
%
% distance(x1,a1,a2,b1,b2,a,b,c) returns the total distance
% from the points A=(a1 a2) and B=(b1 b2) to the point X=(x1 x2)
% where x2 = a*x1^2 + b*x1 + c
%
x2=a*x1^2 + b*x1 + c;
dist=((x1-a1)^2 + (x2-a2)^2)^0.5 + ((x1-b1)^2 + (x2-b2)^2)^0.5;
