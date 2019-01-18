% Applied Optimization with MATLAB
% P.Venkataraman
% Publishe by John Wiley and Sons
%
% Chapter 9  Global Optimization
% Example of Unconstrained Function
% 
% Minimize f(x,y) = -20*sin(R)/sqrt(R)
% R = sqrt((x-4)^2 + (y-4)^2 + + 0.1)
format compact

x = -10:0.5:10;
y = -10:0.5:10;

[X, Y] = meshgrid(x,y);

R = sqrt((X-4).^2 + (Y-4).^2 + 0.1);  % to prevent division by zero
% this is not actually the sinc function
figure
set(gcf,'Name','Contour for Example 9.1')
f = -20*sin(R)./R;
colormap(bone)
[c, h] = contourf(x,y,f,[-19,-10,-5,-2,-1,-0.5,1,2,3,4]);

clabel(c,h)
% contour labels crowd the figure - use color to understand
colorbar
title('Several Minima and Maxima with global solution- Contour')
xlabel('x_1 - values')
ylabel('x_2 - values')
zlabel('f(x_1,x_2)')

figure
set(gcf,'Name','Mesh for Example 9.1')

mesh(x,y,f)
title('Several Minima and Maxima with global solution- Mesh')
xlabel('x_1 - values')
ylabel('x_2 - values')
zlabel('f(x_1,x_2)')

