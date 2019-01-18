function [xmin,ymin,evals,length] = dichotomous(a,b,epsil,n,fun,varargin)
% (c) jskl UoM
%
% dichotomous(a,b,epsil,n,fun,varargin) finds a minimum of a univariate 
% scalar function by using the "dichotomous search" algorithm.
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
% evals = total number of function evaluations (2 per iteration)
% length = length of the last interval
%
% Example use:
%
% [xmin,ymin,evals,length] = dichotomous(-3,5,1e-6,10,'ex_dich')
%
% Where ex_dich is a function defined by:
%
% function [y] = ex_dich(x)
% y=x*x+2*x;
%
delta = epsil/10;
evals = 1;
if n>0
  disp('Starting Interval:')
  disp([a,b])
  n = n-1;
  i = 0;
end
while b-a >= epsil
   middle = (a+b)/2;
   lambda = middle - delta;
   mu = middle + delta;
   if feval(fun,lambda,varargin{:}) < feval(fun,mu,varargin{:})
      b = mu;
   else
      a = lambda;
   end;
   if n>0
     i = i+1;
     disp(['Interval after iteration ' int2str(i)])
     disp([a,b])
     n = n-1;
   end
   evals = evals + 2;
end
xmin = (a+b)/2;
ymin = feval(fun,xmin,varargin{:});
length = b-a;

