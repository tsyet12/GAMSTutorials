function [X,Y,Z] = contourshow(minx,maxx,stepx,miny,maxy,stepy,lines,f,varargin)
% (c) jskl UoM
%
% contourshow(minx,maxx,stepx,miny,maxy,stepy,lines,f,varargin)
% shows contours of a scalar function of 2 scalar arguments.
%
% Input arguments:
%
% minx  = minimum x value (minx < maxx assumed)
% maxx  = maximum x value (last x point is above maxx)
% stepx = mesh x step
% miny  = minimum y value (miny < maxy assumed)
% maxy  = maximum y value (last y point is above maxy)
% stepy = mesh y step
% lines = number of contour lines
% f     = function f(x,y,p) where x,y are scalars, p is a list of parameters
% varargin = list of parameters passed to the function f after x and y
%
% Returns [X,Y,Z] where:
%
% X = vector of x values
% Y = vector of y values
% Z = matrix of f(x,y,p) values
%
% Example use:
%
% contourshow(-1,2,0.05,-2,1,0.05,25,'tstf',1,0);
%
% Where tstf is a function defined by:
%
% function d = tstf(x,y,c1,c2)
% d = (x-c1)^2 + (y - c2)^2;       % squared distance from (c1,c2)
%
maxi=ceil((maxx-minx)/stepx);
maxj=ceil((maxy-miny)/stepy);
Ix=[0:maxi];                       % Ix = X indexes
Iy=[0:maxj];                       % Iy = Y indexes
X=minx+Ix*stepx;                   % X = x values [minx,>maxx]
Y=miny+Iy*stepy;                   % Y = y values [miny,>maxy]
[XX,YY] = meshgrid(X,Y);           % matrices of x and y values
for i=1:maxi+1
    for j=1:maxj+1                 % Z = f(x,y) values
        Z(j,i)=feval(f,XX(j,i),YY(j,i),varargin{:});
    end
end
contour(X,Y,Z,lines);              % contours Z against X and Y
xlabel('x');                       % x-axis label
ylabel('y');                       % y-axis label
title('f(x,y) contour');           % graph caption
