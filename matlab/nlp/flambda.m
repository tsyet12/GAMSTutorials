function [y] = flambda(lambda,fun,x,d,varargin)
%
% Directional univariate function for gradient search
%
% fun = name of the multivariate scalar function
% x = starting point (vector)
% d = direction (vector)
%
y = feval(fun,x + lambda*d,varargin{:});