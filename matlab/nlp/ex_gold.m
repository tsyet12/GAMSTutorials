function [y] = ex_gold(x)
%
% Example function for golden section search:
% y=(2-x.*x+x.^3)./(2+x+x.^3)
%
y=(2-x.*x+x.^3)./(2+x+x.^3);
