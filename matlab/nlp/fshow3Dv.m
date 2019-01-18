function [X,Y,Z] = fshow3Dv(minx,maxx,stepx,miny,maxy,stepy,f,varargin)
% (c) jskl UoM
%
% fshow3Dv(minx,maxx,stepx,miny,maxy,stepy,f,varargin)
% shows mesh of a scalar function of one 2-vector argument.
%
% Input arguments:
%
% minx  = minimum x value (minx < maxx assumed)
% maxx  = maximum x value (last x point is above maxx)
% stepx = mesh x step
% miny  = minimum y value (miny < maxy assumed)
% maxy  = maximum y value (last y point is above maxy)
% stepy = mesh y step
% f     = scalar function f(x,p) where x is a 2-vector, p is a list of parameters
% varargin = list of parameters passed to the function f after x
%
% Returns [X,Y,Z] where:
%
% X = vector of x values
% Y = vector of y values
% Z = matrix of f(x,y) values
%
% Example use:
%
% fshow3Dv(-1,2,0.05,-2,1,0.05,'tstfv',[0 0]);
%
% Where tstfv is a function defined by:
%
% function d = tstfv(x,c)
% d = (x(1)-c(1))^2 + (x(2)-c(2))^2;  % squared distance from c
%
m=ceil((maxx-minx)/stepx);
n=ceil((maxy-miny)/stepy);
Ix=[0:m];                          % Ix = X indexes
Iy=[0:n];                          % Iy = Y indexes
X=minx+Ix*stepx;                   % X = x values [minx,>maxx]
Y=miny+Iy*stepy;                   % Y = y values [miny,>maxy]
for i=1:n+1    % NOT IN VECTOR WAY ! (Functions then use normal operators)
    for j=1:m+1
        Z(i,j)=feval(f,[X(j) Y(i)]',varargin{:}); % Z = f(x,y) values
    end
end  
mesh(X,Y,Z);                       % mesh of Z against X and Y
xlabel('x');                       % x-axis label
ylabel('y');                       % y-axis label
zlabel('f(x,y)');                  % z-axis label

 