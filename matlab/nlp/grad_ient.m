function [xmin,fmin,evals,epsilo] = grad_ient(x,epsil,f,nablaf,varargin)
% (c) jskl UoM
%
% grad_ient(x,epsil,f,nablaf,varargin) finds a minimum of a multivariate  
% convex scalar function by using the gradient = steepest descent algorithm
%
% x        = starting point (column n-vector)
% epsil    = precision
% f        = scalar multivariate function
% nablaf   = column vector multivariate gradient function name
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
% [xmin,fmin,evals,epsilo] = grad_ient([1 2]',1e-9,'ex_grad','nabla_ex_grad',2,4,3)
%
% Where ex_grad is a function defined by:
%
% function [y] = ex_grad(x,a,b,c)
% y = a*x(1)*x(1) + b*x(2)*x(2) + c*x(1)*x(2);
%
% and nabla_ex_grad is a function defined by:
%
% function [g] = nabla_ex_grad(x,a,b,c)
% g = [2*a*x(1) + c*x(2); 2*b*x(2) + c*x(1)];
%
% Try also:
% [xmin,fmin,evals,epsilo] = grad_ient([0 3]',1e-5,'ex_cycBS','nabla_ex_cycBS')
% [xmin,fmin,evals,epsilo] = grad_ient([-2 2]',1e-5,'banana','nabla_banana')
%
evals = 0;
grad = feval(nablaf,x,varargin{:});     % computing gradient vector
OPT = optimset('Display','off');        % to turn off reports from fminsearch
while norm(grad) >= epsil
   lambda = fminsearch('flambda',0,OPT,f,x,-grad,varargin{:});
   %
   % function [y] = flambda(lambda,fun,x,d,varargin)
   % Directional univariate function for gradient search
   % y = feval(fun,x + lambda*d,varargin{:})
   %
   x = x - lambda*grad;                 % moving to the new point
   grad = feval(nablaf,x,varargin{:});  % computing new gradient
   evals = evals + 1;
end
xmin = x;
fmin = feval(f,x,varargin{:});
epsilo = norm(grad);