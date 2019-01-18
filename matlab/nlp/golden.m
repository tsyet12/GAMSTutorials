function [xmin,ymin,evals,length] = golden(a,b,epsil,n,fun,varargin)
% (c) jskl UoM
%
% golden(a,b,epsil,n,fun,varargin) finds a minimum of a univariate 
% scalar function by using the "golden search" algorithm.
%
% a = left bound of the uncertainty interval (a < b assumed)
% b = right bound of the uncertainty interval
% epsil = precision (length of interval)
% n = number of intervals to output in command window
% fun = scalar univariate function
% varargin = list of parameters passed to the function fun after x
%
% Returns [xmin,ymin,evals,length] where:
%
% xmin = the minimum (the middle of the last interval)
% ymin = fun(xmin)
% evals = total number of function evaluations (1 per iteration)
% length = length of the last interval
%
% Example use:
%
% [xmin,ymin,evals,length] = golden(-3,5,1e-6,10,'ex_dich')
%
% Where ex_dich is a function defined by:
%
% function [y] = ex_dich(x)
% y=x*x+2*x;
%
alpha = 0.61803398874989;
evals = 3;
lambda = a + (1-alpha)*(b-a);
mu = a + alpha*(b-a);
flambda = feval(fun,lambda,varargin{:});
fmu = feval(fun,mu,varargin{:});
if n>0
  disp('Starting Interval:')
  disp([a,b])
  n = n-1;
  i = 0;
end
while b-a >= epsil
   if flambda > fmu
      a = lambda;
      lambda = mu;
      flambda = fmu;
      mu = a + alpha*(b-a);
      fmu = feval(fun,mu,varargin{:});
   else
      b = mu;
      mu = lambda;
      fmu = flambda;
      lambda = a + (1-alpha)*(b-a);
      flambda = feval(fun,lambda,varargin{:});
   end;
   if n>0
     i = i+1;
     disp(['Interval after iteration ' int2str(i)])
     disp([a,b])
     n = n-1;
   end
   evals = evals + 1;
end
xmin = (a+b)/2;
ymin = feval(fun,xmin,varargin{:});
length = b-a;
