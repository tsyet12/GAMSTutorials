function [X,Y,Z] = fshow3D(minx,maxx,stepx,miny,maxy,stepy,f,varargin)
% (c) jskl UoM
%
% fshow3D(minx,maxx,stepx,miny,maxy,stepy,f,varargin)
% shows mesh of a scalar function of 2 scalar arguments.
%
% Input arguments:
%
% minx  = minimum x value (minx < maxx assumed)
% maxx  = maximum x value (last x point is above maxx)
% stepx = mesh x step
% miny  = minimum y value (miny < maxy assumed)
% maxy  = maximum y value (last y point is above maxy)
% stepy = mesh y step
% f     = function f(x,y,p) where x,y are scalars, p is a list of parameters
% varargin = list of parameters passed to the function f after x and y
%
% Returns [X,Y,Z] where:
%
% X = vector of x values
% Y = vector of y values
% Z = matrix of f(x,y) values
%
% Example use:
%
% fshow3D(-1,2,0.05,-2,1,0.05,'tstf',0,0);
%
% Where testf is a function defined by:
%
% function d = tstf(x,y,c1,c2)
% d = (x-c1)^2 + (y - c2)^2;       % squared distance from (c1,c2)
%
m=ceil((maxx-minx)/stepx);
n=ceil((maxy-miny)/stepy);
Ix=[0:m];                          % Ix = X indexes
Iy=[0:n];                          % Iy = Y indexes
X=minx+Ix*stepx;                   % X = x values [minx,>maxx]
Y=miny+Iy*stepy;                   % Y = y values [miny,>maxy]
for i=1:n+1    % NOT IN VECTOR WAY ! (Functions then use normal operators)
    for j=1:m+1
        Z(i,j)=feval(f,X(j),Y(i),varargin{:}); % Z = f(x,y) values
    end
end  
mesh(X,Y,Z);                       % mesh of Z against X and Y
xlabel('x');                       % x-axis label
ylabel('y');                       % y-axis label
zlabel('f(x,y)');                  % z-axis label

 