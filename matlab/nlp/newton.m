function [xmin,fmin,evals,epsilo] = newton(x,epsil,f,nablaf,hessianf,varargin)
% (c) jskl UoM
%
% newton(x,epsil,f,nablaf,hessianf,varargin)
% finds a minimum of a multivariate scalar function by using the Newton's method. 
% Hessian is supposed to be non-singular.
%
% x        = starting point (column n-vector)
% epsil    = precision (gradient norm)
% f        = multivariate scalar objective function
% nablaf   = returns the gradient of f (column n-vector)
% hessianf = returns the hessian matrix of f (nxn matrix)
% varargin = list of parameters passed to the functions f, nablaf and hessianf after x
%
% Returns [xmin,fmin,evals,epsilo] where:
%
% xmin  = the minimum
% fmin  = f(xmin)
% evals = number of iterations
% epsilo = norm of the last gradient
%
% Example use:
%
% [xmin,fmin,evals,epsilo] = newton([-2 1]',1e-4,'ex_grad','nabla_ex_grad','H_ex_grad',2,4,3)
%
% Where ex_grad is a function defined by:
%
% function [y] = ex_grad(x,a,b,c)
% y = a*x(1)*x(1) + b*x(2)*x(2) + c*x(1)*x(2);
%
% nabla_ex_grad is a function defined by:
%
% function g = nabla_ex_grad(x,a,b,c)
% g = [2*a*x(1) + c*x(2); 2*b*x(2) + c*x(1)];
%
% H_ex_grad is a function defined by:
%
% function H = H_ex_grad(x,a,b,c)
% H = [2*a  c; c  2*b];
%
% Try also:
% [xmin,fmin,evals,epsilo] = newton([0 3]',1e-5,'ex_cycBS','nabla_ex_cycBS','H_ex_cycBS')
% [xmin,fmin,evals,epsilo] = newton([-2 2]',1e-5,'banana','nabla_banana','H_banana')
%
% Line search example use (functions return f, f', f''):
%
% [xmin,fmin,evals,epsilo] = newton(5,1e-4,'fexN','fprimeN','fdoubleprimeN')
%
evals = 0;
grad = feval(nablaf,x,varargin{:});     % computing gradient vector
while norm(grad) >= epsil
   H = feval(hessianf,x,varargin{:});   % computing Hessian
   d = -H\grad;                         % computing exact move
   x = x + d;                           % moving to the new point
   grad = feval(nablaf,x,varargin{:});  % computing new gradient
   evals = evals + 1;
end
xmin = x;
fmin = feval(f,x,varargin{:});
epsilo = norm(grad);