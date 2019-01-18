function [d] = tstfv(x,c1,c2)
% (c) jskl 2003
% tstfv is a test function of one vector variable in R^2
%
d = (x(1)-c1)^2 + (x(2) - c2)^2;       % squared distance from (c1,c2)

