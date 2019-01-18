function [X,Y,Z] = contourshowv(minx,maxx,stepx,miny,maxy,stepy,lines,f,varargin)
% (c) jskl UoM
%
% contourshowv(minx,maxx,stepx,miny,maxy,stepy,lines,f,varargin)
% shows contours of a scalar function of one 2-vector argument.
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
% f     = scalar function f(x,p) where x is a 2-vector, p is a list of parameters
% varargin = list of parameters passed to the function f after x
%
% Returns [X,Y,Z] where:
%
% X = vector of x values
% Y = vector of y values
% Z = matrix of f(x,p) values
%
% Example use:
%
% contourshowv(-1,2,0.05,-2,1,0.05,25,'tstfv',[1 0]);
%
% Where tstfv is a function defined by:
%
% function d = tstfv(x,c)
% d = (x(1)-c(1))^2 + (x(2)-c(2))^2;  % squared distance from c
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
        Z(j,i)=feval(f,[XX(j,i) YY(j,i)]',varargin{:});
    end
end
contour(X,Y,Z,lines);              % contours Z against X and Y
xlabel('x');                       % x-axis label
ylabel('y');                       % y-axis label
title('f(x,y) contour');           % graph caption

 