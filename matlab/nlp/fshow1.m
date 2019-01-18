function [X,Y] = fshow1(min,max,step,fun,s,varargin)
% (c) jskl 2002
%
% fshow1(min,max,step,fun,s,varargin) shows the graph 
% of a univariate scalar function where:
%
% min  = minimum x value (min < max assumed)
% max  = maximum x value (last x point is above max)
% step = graph step
% fun  = function name (string), its 1st parameter must be "x"
% s = line properties string (see "help plot")
% varargin = list of parameters passed to the function "fun" after "x"
%
% Returns [X,Y] where:
%
% X = vector of x values
% Y = vector of f(x) values
%
% Example use:
%
% [X,Y] = fshow1(-1,7,0.05,'modsin','r:',2,3,1);  {red, dotted line}
%
% Where modsin is a function defined by:
%
% function [y] = modsin(x,a,b,c)
% y=a*sin(b*x+c);
%
I=[0:ceil((max-min)/step)];    % I = indexes
X=min+I*step;                  % X = x values [min,>max]
Y=feval(fun,X,varargin{:});    % Y = f(x) values
plot(X,Y,s);                   % plots Y against X
xlabel('x');                   % x-axis label
ylabel(strcat(fun,'(x)'));     % y-axis label

