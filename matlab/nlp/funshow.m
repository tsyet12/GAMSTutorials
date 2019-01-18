function [X,Y] = funshow(min,max,step,fun,varargin)
% (c) jskl 2002
% funshow shows the graph of a univariate scalar function
%
% min  = minimum x value (min < max assumed)
% max  = maximum x value (last x point is above max)
% step = graph step
% fun  = function name (string)
% varargin = list of parameters passed to the function "fun" after "x"
%
% Returns [X,Y] where:
%
% X = vector of x values
% Y = vector of f(x) values
%
% Example use:
%
% [X,Y] = funshow(-1,7,0.05,'modsin',2,3,1);
%
% Where modsin is a function defined by:
%
% function [y] = modsin(x,a,b,c)
% y=a*sin(b*x+c);
%
I=[0:ceil((max-min)/step)];    % I = indexes
X=min+I*step;                  % X = x values [min,>max]
Y=feval(fun,X,varargin{:});    % Y = f(x) values
plot(X,Y);                     % plots Y against X
xlabel('x');                   % x-axis label
ylabel(strcat(fun,'(x)'));     % y-axis label

