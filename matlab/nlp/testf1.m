function [d] = testf1(x,y,c1,c2)
% (c) jskl 2002
% testf1 returns the squared distance between (x,y) and (c1,c2)
%
% example use:
%
% x=3
% y=4
% dist = testf1(x,y,0,0)
%
d = (x-c1).^2 + (y - c2).^2;

