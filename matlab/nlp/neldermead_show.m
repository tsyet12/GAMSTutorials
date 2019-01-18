function [xmin,fmin,evals,epsilo,ls,fs] = neldermead_show(s,epsil,alpha,beta,gama,minx,maxx,stepx,miny,maxy,stepy,lines,ns,f,varargin)
% (c) jskl UoM
%
% neldermead_show(s,epsil,alpha,beta,gama,minx,maxx,stepx,miny,maxy,stepy,lines,f,varargin)
% finds a minimum of a bivariate scalar function by using the Nelder
% and Mead (moving simplex) algorithm. Search steps are shown on function contours.
%
% s        = n x (n+1) matrix with starting simplex (simplex points are column n-vectors)
% epsil    = precision (distance between the best and the worst points)
% alpha    = coefficient of reflection
% beta     = coefficient of contraction
% gama     = coefficient of expansion
% minx     = minimum x value for contours (minx < maxx assumed)
% maxx     = maximum x value for contours (last x point is above maxx)
% stepx    = mesh x step
% miny     = minimum y value for contours (miny < maxy assumed)
% maxy     = maximum y value for contours (last y point is above maxy)
% stepy    = mesh y step
% lines    = number of contour lines
% ns       = number of simplexes to output in command window
% f        = scalar bivariate function
% varargin = list of parameters passed to the function f after x
%
% Returns [xmin,fmin,evals,epsilo,ls,fs] where:
%
% xmin   = the minimum (the best point of the last simplex)
% fmin   = f(xmin)
% evals  = number of function evaluations
% epsilo = last distance between the best and the worst points
% ls = last simplex (simplex points in columns)
% fs = function values at last simplex
%
% Example use:
%
% [xmin,fmin,evals,epsilo,ls,fs] = neldermead_show([1 1 2;1 2 1],1e-3,1,0.5,1.5,-2.0,3.0,0.05,-1,3.1,0.05,50,20,'ex_cyc',2,4,3)
%
% Where ex_cyc is a function defined by:
%
% function [y] = ex_cyc(x,a,b,c)
% y = a*x(1)*x(1) + b*x(2)*x(2) + c*x(1)*x(2);
%
% Try also:
% [xmin,fmin,evals,epsilo,ls,fs] = neldermead_show([0 1 0;2 2 1],1e-3,1,0.5,1.5,0,3.5,0.05,0,3.1,0.05,40,20,'ex_cycBS')
% [xmin,fmin,evals,epsilo,ls,fs] = neldermead_show([-1 -2 -1;-2 0 -1],1e-3,1,0.5,1.5,-2,2,0.05,-3,2,0.05,40,20,'banana')
%
evals = 0;
n = length(s) - 1;
hold off;
plot([0],[0]);                          % clearing last plot (if any)
style = 'k-';                           % line style
contourshowv(minx,maxx,stepx,miny,maxy,stepy,lines,f,varargin{:});
hold on;
for i=1:n+1
  fs(i) = feval(f,s(:,i),varargin{:});  % computing f at simplex points
  evals = evals + 1;
end
[fr,ir]=min(fs);                        % the best point (value and index)
xr = s(:,ir);
[fss,is]=max(fs);                       % the worst point (value and index)
xs = s(:,is);
epsilo = norm(xs-xr);
plot([s(1,1) s(1,2)],[s(2,1) s(2,2)]);  % show the first simplex triangle
plot([s(1,1) s(1,3)],[s(2,1) s(2,3)]);
plot([s(1,2) s(1,3)],[s(2,2) s(2,3)]);
if ns>0
  disp('Starting simplex:')
  disp(s)
  ns = ns-1;
end
while epsilo >= epsil                   % stop when maximum distance from best smaller than epsil
  xbar = (sum(s')'-xs)/n;               % average point except the worst one
  xhat = xbar + alpha*(xbar-xs);        % reflection
  fhat = feval(f,xhat,varargin{:});
  evals = evals + 1;
  if fr > fhat                          % xhat very good
    xe = xbar + gama*(xhat-xbar);       % expansion
    fe = feval(f,xe,varargin{:});
    evals = evals + 1;
    if fhat > fe                        % expansion was good - keep xe
      style = 'r-';                     % expansion in red
      s(:,is) = xe;                     % replace worst with xe
      fs(is) = fe;
      if ns>0
        disp('Expansion to:')
        disp(s)
        ns = ns-1;
      end
    else                                % expansion was not good - keep xhat
      style = 'k-';                     % reflection in black
      s(:,is) = xhat;                   % replace worst with xhat
      fs(is) = fhat;
      if ns>0
        disp('Reflection (after rejected expansion) to:')
        disp(s)
        ns = ns-1;
      end
    end
  else                                  % xhat not very good
    fs(is) = fs(ir);                    % replacing just for next search
    [fsss,iss]=max(fs);                 % worst point except the worst one
    if fsss >= fhat                     % xhat acceptable
      style = 'k-';                     % reflection in black
      s(:,is) = xhat;                   % replace worst with xhat
      fs(is) = fhat;
      if ns>0
        disp('Reflection (not good, but accepted) to:')
        disp(s)
        ns = ns-1;
      end
    else                                % xhat bad - correction needed
      if fhat < fss                     % find xprime - better of xhat,xs
        xprime = xhat;
        fprime = fhat;
      else
        xprime = xs;
        fprime = fss;
      end
      xdprime = xbar + beta*(xprime - xbar);   % contraction
      fdprime = feval(f,xdprime,varargin{:});
      evals = evals + 1;
      if fdprime <= fprime              % contraction OK
        style = 'g-';                   % contraction in green
        s(:,is) = xdprime;              % replace worst with xdprime
        fs(is) = fdprime;
        if ns>0
          disp('Contraction to:')
          disp(s)
          ns = ns-1;
        end
      else                              % contraction not good, shrink simplex
        style = 'y-';                   % shrinking in yellow
        for i=1:n+1
          if i~=ir
            s(:,i) = s(:,i) + 0.5*(xr-s(:,i));    % shrinking simplex towards the best point
            fs(i) = feval(f,s(:,i),varargin{:});  % computing f at simplex points
            evals = evals + 1;
          end
        end
        if ns>0
          disp('Shrinking simplex to:')
          disp(s)
          ns = ns-1;
        end
      end
    end
  end
  plot([s(1,1) s(1,2)],[s(2,1) s(2,2)],style);    % show the next simplex triangle
  plot([s(1,1) s(1,3)],[s(2,1) s(2,3)],style);
  plot([s(1,2) s(1,3)],[s(2,2) s(2,3)],style);
  [fr,ir]=min(fs);                      % new best point (value and index)
  xr = s(:,ir);
  [fss,is]=max(fs);                     % new worst point (value and index)
  xs = s(:,is);    
  epsilo = norm(xs-xr);
end %while
xmin = xr;
fmin = fr;
ls = s;
