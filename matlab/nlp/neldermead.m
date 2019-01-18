function [xmin,fmin,evals,epsilo,ls,fs] = neldermead(s,epsil,alpha,beta,gama,f,varargin)
% (c) jskl UoM
%
% neldermead(s,epsil,alpha,beta,gama,f,varargin)
% finds a minimum of a multivariate scalar function by using the Nelder
% and Mead (moving simplex) algorithm.
%
% s        = n x (n+1) matrix with starting simplex (simplex points are column n-vectors)
% epsil    = precision (distance between the best and the worst points)
% alpha    = coefficient of reflection
% beta     = coefficient of contraction
% gama     = coefficient of expansion
% f        = scalar multivariate function
% varargin = list of parameters passed to the function f after x
%
% Returns [xmin,fmin,evals,epsilo] where:
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
% [xmin,fmin,evals,epsilo,ls,fs] = neldermead([3 5 3;3 3 5],1e-9,1,0.5,1.5,'ex_cyc',2,4,3)
%
% Where ex_cyc is a function defined by:
%
% function [y] = ex_cyc(x,a,b,c)
% y = a*x(1)*x(1) + b*x(2)*x(2) + c*x(1)*x(2);
%
% Try also:
% [xmin,fmin,evals,epsilo,ls,fs] = neldermead([0 1 0;2 2 1],1e-9,1,0.5,1.5,'ex_cycBS')
% [xmin,fmin,evals,epsilo,ls,fs] = neldermead([-1 -2 -1;-2 0 -1],1e-9,1,0.5,1.5,'banana')
%
evals = 0;
n = length(s) - 1;
for i=1:n+1
  fs(i) = feval(f,s(:,i),varargin{:});  % computing f at simplex points
  evals = evals + 1;
end
[fr,ir]=min(fs);                        % the best point (value and index)
xr = s(:,ir);
[fss,is]=max(fs);                       % the worst point (value and index)
xs = s(:,is);
epsilo = norm(xs-xr);
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
      s(:,is) = xe;                     % replace worst with xe
      fs(is) = fe;
    else                                % expansion was not good - keep xhat
      s(:,is) = xhat;                   % replace worst with xhat
      fs(is) = fhat;
    end
  else                                  % xhat not very good
    fs(is) = fs(ir);                    % replacing just for next search
    [fsss,iss]=max(fs);                 % worst point except the worst one
    if fsss >= fhat                     % xhat acceptable
      s(:,is) = xhat;                   % replace worst with xhat
      fs(is) = fhat;
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
        s(:,is) = xdprime;              % replace worst with xdprime
        fs(is) = fdprime;
      else                              % contraction not good, shrink simplex
        for i=1:n+1
          if i~=ir
            s(:,i) = s(:,i) + 0.5*(xr-s(:,i));    % shrinking simplex towards the best point
            fs(i) = feval(f,s(:,i),varargin{:});  % computing f at simplex points
            evals = evals + 1;
          end
        end
      end
    end
  end
  [fr,ir]=min(fs);                      % new best point (value and index)
  xr = s(:,ir);
  [fss,is]=max(fs);                     % new worst point (value and index)
  xs = s(:,is);    
  epsilo = norm(xs-xr);
end %while
xmin = xr;
fmin = fr;
ls = s;
