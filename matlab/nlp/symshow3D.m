function [X,Y,Z] = symshow3D(minx,maxx,stepx,miny,maxy,stepy,fsym)
% (c) jskl UoM
%
% symshow3D shows the mesh of a 2-dimensional scalar symbolic function.
%
% minx  = minimum x value (minx < maxx assumed)
% maxx  = maximum x value (last x point is above maxx)
% stepx = mesh x step
% miny  = minimum y value (miny < maxy assumed)
% maxy  = maximum y value (last y point is above maxy)
% stepy = mesh y step
% fsym = function (symbolic expression), its arguments must be "x" and "y"
%
% Returns [X,Y,Z] where:
%
% X = vector of x values
% Y = vector of y values
% Z = matrix of f(x,y) values
%
% Example use:
%
% symshow3D(-1,2,0.05,-2,1,0.05,s);
%
% Where s contains for example 4*x^2+3*x+5*y^2-4*y+20*x*y-5
% Create s as follows: >>s = sym('4*x^2+3*x+5*y^2-4*y+20*x*y-5')
%
m=ceil((maxx-minx)/stepx);
n=ceil((maxy-miny)/stepy);
Ix=[0:m];                          % Ix = X indexes
Iy=[0:n];                          % Iy = Y indexes
X=minx+Ix*stepx;                   % X = x values [minx,>maxx]
Y=miny+Iy*stepy;                   % Y = y values [miny,>maxy]
[XX,YY] = meshgrid(X,Y);           % matrices of x and y values
for i=1:length(X)    % NOT IN VECTOR WAY ! (Functions then use normal operators)
    for j=1:length(Y)
        x=XX(j,i);
        y=YY(j,i);
        Z(j,i)=eval(fsym);         % Z = f(x,y) values
    end
end  
mesh(X,Y,Z);                       % mesh of Z against X and Y
xlabel('x');                       % x-axis label
ylabel('y');                       % y-axis label
zlabel('f(x,y)');                  % z-axis label
