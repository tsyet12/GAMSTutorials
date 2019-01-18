function [xmin,fmin,evals,epsilo] = fletcherreeves(x,epsil,f,nablaf,varargin)
% (c) jskl UoM
%
% fletcherreeves(x,epsil,f,nablaf,varargin)
% finds a minimum of a multivariate scalar function by using the Fletcher-Reeves
% conjugate gradient algorithm.
%
% x        = starting point (column n-vector)
% epsil    = precision
% f        = scalar function
% nablaf   = column vector gradient function
% varargin = list of parameters passed to the functions f and nablaf after x
%
% Returns [xmin,fmin,evals,epsilo] where:
%
% xmin  = the minimum
% fmin  = f(xmin)
% evals = number of iterations (line searches)
% epsilo = norm of last gradient
%
% Example use:
%
% [xmin,fmin,evals,epsilo] = fletcherreeves([1 2]',1e-9,'ex_grad','nabla_ex_grad',2,4,3)
%
% Where ex_grad is a function defined by:
%
% function [y] = ex_grad(x,a,b,c)
% y = a*x(1)*x(1) + b*x(2)*x(2) + c*x(1)*x(2);
%
% and nabla_ex_grad is a function defined by:
%
% function g = nabla_ex_grad(x,a,b,c)
% g = [2*a*x(1) + c*x(2); 2*b*x(2) + c*x(1)];
%
% Try also:
% [xmin,fmin,evals,epsilo] = fletcherreeves([0 3]',1e-5,'ex_cycBS','nabla_ex_cycBS')
% [xmin,fmin,evals,epsilo] = fletcherreeves([-2 2]',1e-5,'banana','nabla_banana')
%
evals = 0;
n = length(x);
grad = feval(nablaf,x,varargin{:});     % computing gradient vector
OPT = optimset('Display','off');        % to turn off reports from fminsearch
while norm(grad) >= epsil
  d = -grad;
  for i=1:n
   lambda = fminsearch('flambda',0,OPT,f,x,d,varargin{:});
   %
   % function [y] = flambda(lambda,fun,x,d,varargin)
   % Directional univariate function for gradient search
   % y = feval(fun,x + lambda*d,varargin{:})
   %
   x = x + lambda*d;                    % moving to the new point
   grad = feval(nablaf,x,varargin{:});  % computing new gradient
   alpha = (norm(grad)^2)/(norm(d)^2);
   d = -grad + alpha*d;                 % next deflected direction
   evals = evals + 1;
  end
end
xmin = x;
fmin = feval(f,x,varargin{:});
epsilo = norm(grad);