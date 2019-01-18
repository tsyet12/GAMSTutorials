function [X,Y] = fshow(min,max,step,fun,varargin)
% (c) jskl UoM
%
% fshow(min,max,step,fun,varargin) shows the graph 
% of a univariate scalar function where:
%
% min  = minimum x value (min < max assumed)
% max  = maximum x value (last x point is above max)
% step = graph step
% fun  = univariate function, its 1st parameter must be "x"
% varargin = list of parameters passed to the function "fun" after "x"
%
% Returns [X,Y] where:
%
% X = vector of x values
% Y = vector of f(x) values
%
% Example use:
%
% fshow(-1,7,0.05,'modsin',2,3,1);
%
% Where modsin is a function defined by:
%
% function [y] = modsin(x,a,b,c)
% y=a*sin(b*x+c);
%
n=ceil((max-min)/step);
I=[0:n];                       % I = indexes
X=min+I*step;                  % X = x values [min,>max]
for j=1:n+1 % NOT IN VECTOR WAY ! (Functions then use normal operators)
   Y(j)=feval(fun,X(j),varargin{:}); % Y = f(x) values
end
plot(X,Y);                     % plots Y against X
xlabel('x');                   % x-axis label
ylabel('f(x)');                % y-axis label
