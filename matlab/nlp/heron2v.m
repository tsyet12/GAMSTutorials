function [dist] = heron2v(x1,a1,a2,b1,b2,a,b,c)
%
% distance(x1,a1,a2,b1,b2,a,b,c) returns the total distance
% from the points A=(a1 a2) and B=(b1 b2) to the point X=(x1 x2)
% where x2 = a*x1^2 + b*x1 + c
%
dist=((x1-a1).^2 + (a.*x1.*x1+b.*x1+c - a2).^2).^0.5 + ((x1-b1).^2 + (a.*x1.*x1+b.*x1+c - b2).^2).^0.5;
