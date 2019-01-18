function [xmin,ymin,evals,length] = bisection(a,b,epsil,n,fun,varargin)
% (c) jskl UoM
%
% bisection(a,b,epsil,n,fun,varargin) finds a root of a univariate 
% increasing scalar function by using the "bisection search" algoritm.
% It solves fun(x)=0, so to search for minimum,
% fun must be the first derivative !
%
% a = left bound of the uncertainty interval (a < b assumed)
% b = right bound of the uncertainty interval
% epsil = precision (length of interval)
% n = number of intervals to output in command window
% fun  = scalar univariate function
% varargin = list of parameters passed to the function fun after x
%
% Returns [xmin,ymin,evals,length] where:
%
% xmin  = the minimum (the middle of the last interval)
% ymin = fun(xmin)
% evals = total number of function evaluations (1 per iteration)
% length = length of the last interval
%
% Example use:
%
% [xmin,ymin,evals,length] = bisection(-3,5,1e-6,10,'fprime')
%
% Where fprime is a function defined by:
%
% function [y] = fprime(x)
% y=2*x +2;    % derivative of f(x)=x^2+2x
%
evals = 1;
N = ceil(log2((b-a)/epsil));
if n>0
  disp('Starting Interval:')
  disp([a,b])
  n = n-1;
  i = 0;
end
for i=1:N
   middle = (a+b)/2;
   fm = feval(fun,middle,varargin{:});
   if fm < 0
      a = middle;
   else
      b = middle;
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
