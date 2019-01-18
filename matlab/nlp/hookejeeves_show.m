function [xmin,fmin,evals,epsilo] = hookejeeves_show(x,epsil,minx,maxx,stepx,miny,maxy,stepy,lines,f,varargin)
% (c) jskl UoM
%
% hookejeeves_show(x,epsil,minx,maxx,stepx,miny,maxy,stepy,lines,f,varargin)
% finds a minimum of a bivariate scalar function by using the
% Hooke-Jeeves algorithm. Search steps are shown on function contours.
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
% [xmin,fmin,evals,epsilo] = hookejeeves_show([-2 1]',1e-9,-2,2,0.05,-2,2,0.05,25,'ex_cyc',2,4,3)
%
% Where ex_cyc is a function defined by:
%
% function [y] = ex_cyc(x,a,b,c)
% y = a*x(1)*x(1) + b*x(2)*x(2) + c*x(1)*x(2);
%
% Try also:
% [xmin,fmin,evals,epsilo] = hookejeeves_show([0 3]',1e-5,0,3.5,0.05,0,3.1,0.05,40,'ex_cycBS')
% [xmin,fmin,evals,epsilo] = hookejeeves_show([-2 2]',1e-5,-2,2,0.05,-1,3,0.05,40,'banana')
%
evals = 0;
OPT = optimset('Display','off');        % to turn off reports from fminsearch
hold off;
plot([0],[0]);                          % clearing last plot (if any)
contourshowv(minx,maxx,stepx,miny,maxy,stepy,lines,f,varargin{:});
hold on;
z = x + [10 10]';                       % just to have big norm initially
yy = x;                                 % yy for the first acceleration
while norm(x-z) >= epsil
   z = x;
   % search in x direction: 
   lambda = fminsearch('flambda',0,OPT,f,x,[1 0]',varargin{:});
   %
   % function [y] = flambda(lambda,fun,x,d,varargin)
   % Directional univariate function for gradient search
   % y = feval(fun,x + lambda*d,varargin{:})
   %
   y = x;
   x = x + lambda*[1 0]';               % moving to the new point
   plot([y(1) x(1)],[y(2) x(2)]);
   % search in y direction: 
   lambda = fminsearch('flambda',0,OPT,f,x,[0 1]',varargin{:});
   y = x;
   x = x + lambda*[0 1]';               % moving to the new point
   plot([y(1) x(1)],[y(2) x(2)]);
   % acceleration step
   d = x-yy;
   yy = x;                              % yy for next acceleration
   lambda = fminsearch('flambda',0,OPT,f,x,d,varargin{:});
   y = x;
   x = x + lambda*d;                    % moving to the new point
   plot([y(1) x(1)],[y(2) x(2)]);
   evals = evals + 3;
end
xmin = x;
fmin = feval(f,x,varargin{:});
epsilo = norm(x-z);

