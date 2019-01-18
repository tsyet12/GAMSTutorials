function [X,Y,Z] = contourshow1(minx,maxx,stepx,miny,maxy,stepy,lines,fun,varargin)
% (c) jskl 2002
%
% contourshow1(minx,maxx,stepx,miny,maxy,stepy,lines,fun,varargin)
% shows the contour of a 2-dimensional scalar function with VECTOR ARGUMENT
%
% minx  = minimum x value (minx < maxx assumed)
% maxx  = maximum x value (last x point is above maxx)
% stepx = mesh x step
% miny  = minimum y value (miny < maxy assumed)
% maxy  = maximum y value (last y point is above maxy)
% stepy = mesh y step
% lines = number of contour lines
% fun   = function name (string)
% varargin = list of parameters passed to the function fun after x and y
%
% Returns [X,Y,Z] where:
%
% X = vector of x values
% Y = vector of y values
% Z = matrix of f(x,y) values
%
% Example use:
%
% [X,Y,Z] = contourshow1(-1,2,0.05,-2,1,0.05,25,'testc',[1 0]);
%
% Where testc is a function defined by:
%
% function [d] = testc(x,c)
% d = norm(x-c)^2;       % squared distance from c
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
        Z(j,i)=feval(fun,[XX(j,i) YY(j,i)],varargin{:});
    end
end
contour(X,Y,Z,lines);              % contours Z against X and Y
xlabel('x');                       % x-axis label
ylabel('y');                       % y-axis label
title(strcat(fun,'(x,y) contour'));% graph caption



 