function [xmin,fmin,evals,epsilo] = gradient_show(x,epsil,minx,maxx,stepx,miny,maxy,stepy,lines,f,nablaf,varargin)
% (c) jskl UoM
%
% gradient_show(x,epsil,minx,maxx,stepx,miny,maxy,stepy,lines,f,nablaf,varargin)
% finds a minimum of a bivariate scalar function by using the gradient
% (steepest descent) algorithm. Search steps are shown on function contours.
%
% x        = starting point (column 2-vector)
% epsil    = precision
% minx     = minimum x value for contours (minx < maxx assumed)
% maxx     = maximum x value for contours (last x point is above maxx)
% stepx    = mesh x step
% miny     = minimum y value for contours (miny < maxy assumed)
% maxy     = maximum y value for contours (last y point is above maxy)
% stepy    = mesh y step
% lines    = number of contour lines
% f        = scalar bivariate function
% nablaf   = column vector bivariate gradient function
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
% [xmin,fmin,evals,epsilo] = gradient_show([-2 1]',1e-5,-2,2,0.05,-2,2,0.05,25,'ex_grad','nabla_ex_grad',2,4,3)
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
% [xmin,fmin,evals,epsilo] = gradient_show([0 3]',1e-5,0,3.5,0.05,0,3.1,0.05,40,'ex_cycBS','nabla_ex_cycBS')
% [xmin,fmin,evals,epsilo] = gradient_show([-2 2]',1e-5,-2,2,0.05,-1,3,0.05,40,'banana','nabla_banana')
%
evals = 0;
grad = feval(nablaf,x,varargin{:});     % computing gradient vector
OPT = optimset('Display','off');        % to turn off reports from fminsearch
hold off;
plot([0],[0]);                          % clearing last plot (if any)
contourshowv(minx,maxx,stepx,miny,maxy,stepy,lines,f,varargin{:});
hold on;
while norm(grad) >= epsil
   lambda = fminsearch('flambda',0,OPT,f,x,-grad,varargin{:});
   %
   % function [y] = flambda(lambda,fun,x,d,varargin)
   % Directional univariate function for gradient search
   % y = feval(fun,x + lambda*d,varargin{:})
   %
   y = x;
   x = x - lambda*grad;                 % moving to the new point
   plot([y(1) x(1)],[y(2) x(2)]);
   grad = feval(nablaf,x,varargin{:});  % computing new gradient
   evals = evals + 1;
end
xmin = x;
fmin = feval(f,x,varargin{:});
epsilo = norm(grad);