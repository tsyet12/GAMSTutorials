function [X,Y] = symshow(min,max,step,fsym)
% (c) jskl UoM
%
% symshow(min,max,step,fsym) shows the graph 
% of a univariate scalar symbolic function with variable symbol x where:
%
% min  = minimum x value (min < max assumed)
% max  = maximum x value (last x point is above max)
% step = graph step
% fsym = function (symbolic expression), its argument must be "x"
%
% Returns [X,Y] where:
%
% X = vector of x values
% Y = vector of f(x) values
%
% Example use:
%
% symshow(-7,7,0.05,s);
%
% Where s contains for example x^3 [created by: >>s = sym('x^3') ]
%
n=ceil((max-min)/step);
I=[0:n];                       % I = indexes
X=min+I*step;                  % X = x values [min,>max]
for j=1:n+1 % NOT IN VECTOR WAY ! (Functions then use normal operators)
   x=X(j);
   Y(j)=eval(fsym);            % Y = f(x) values
end
plot(X,Y);                     % plots Y against X
xlabel('x');                   % x-axis label
ylabel('f(x)');                % y-axis label

