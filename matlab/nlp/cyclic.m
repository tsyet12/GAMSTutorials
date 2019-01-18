function [xmin,fmin,evals,epsilo] = cyclic(x,epsil,f,varargin)
% (c) jskl UoM
%
% cyclic(x,epsil,f,varargin)
% finds a minimum of a multivariate scalar function by using the cyclic
% co-ordinate algorithm.
%
% x        = starting point (column n-vector)
% epsil    = precision
% f        = scalar multivariate function
% varargin = list of parameters passed to the function f after x
%
% Returns [xmin,fmin,evals,epsilo] where:
%
% xmin  = the minimum
% fmin  = f(xmin)
% evals = number of iterations (line searches)
% epsilo = last distance
%
% Example use:
%
% [xmin,fmin,evals,epsilo] = cyclic([-2 1]',1e-9,'ex_cyc',2,4,3)
%
% Where ex_cyc is a function defined by:
%
% function [y] = ex_cyc(x,a,b,c)
% y = a*x(1)*x(1) + b*x(2)*x(2) + c*x(1)*x(2);
%
% Try also:
% [xmin,fmin,evals,epsilo] = cyclic([0 3]',1e-9,'ex_cycBS')
% [xmin,fmin,evals,epsilo] = cyclic([-2 2]',1e-9,'banana')
%
evals = 0;
OPT = optimset('Display','off');        % to turn off reports from fminsearch
n = length(x);
z = x + ones(n,1);                      % just to have big norm initially
while norm(x-z) >= epsil
  z = x;
  for i=1:n
   % search in xi direction:
   d = zeros(n,1);
   d(i) = 1;
   lambda = fminsearch('flambda',0,OPT,f,x,d,varargin{:});
   %
   % function [y] = flambda(lambda,fun,x,d,varargin)
   % Directional univariate function for gradient search
   % y = feval(fun,x + lambda*d,varargin{:})
   %
   x = x + lambda*d;               % moving to the new point
   evals = evals + 1;
  end
end
xmin = x;
fmin = feval(f,x,varargin{:});
epsilo = norm(x-z);
