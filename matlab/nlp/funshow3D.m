function [X,Y,Z] = funshow3D(minx,maxx,stepx,miny,maxy,stepy,fun,varargin)
% (c) jskl 2002
% funshow3D shows the mesh of a 2-dimensional scalar function
%
% minx  = minimum x value (minx < maxx assumed)
% maxx  = maximum x value (last x point is above maxx)
% stepx = mesh x step
% miny  = minimum y value (miny < maxy assumed)
% maxy  = maximum y value (last y point is above maxy)
% stepy = mesh y step
% fun  = function name (string)
% varargin = list of parameters passed to the function "fun" after "x" and "y"
%
% Returns [X,Y,Z] where:
%
% X = vector of x values
% Y = vector of y values
% Z = matrix of f(x,y) values
%
% Example use:
%
% [X,Y,Z] = funshow3D(-1,2,0.05,-2,1,0.05,'testf1',0,0);
%
% Where testf1 is a function defined by:
%
% function [d] = testf1(x,y,c1,c2)
% d = (x-c1).^2 + (y - c2).^2;     % squared distance from (c1,c2)
%
Ix=[0:ceil((maxx-minx)/stepx)];    % Ix = X indexes
Iy=[0:ceil((maxy-miny)/stepy)];    % Iy = Y indexes
X=minx+Ix*stepx;                   % X = x values [minx,>maxx]
Y=miny+Iy*stepy;                   % Y = y values [miny,>maxy]
[XX,YY] = meshgrid(X,Y);           % matrices of x and y values
Z=feval(fun,XX,YY,varargin{:});    % Z = f(x,y) values
mesh(X,Y,Z);                       % mesh of Z against X and Y
xlabel('x');                       % x-axis label
ylabel('y');                       % y-axis label
zlabel(strcat(fun,'(x,y)'));       % z-axis label

 