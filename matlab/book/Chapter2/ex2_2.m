%	Chapter 2: Optimization with Matlab
%  Dr. P.Venkataraman
%  Example 2 Sec.2.3
%
%	graphical solution using matlab (two design variables)
%  Unconstrained function illustrating global minimum
% 	Example will introduce 3D plots, 3D contours, filled 2D
%  contours and gradient information
%----------------------------------------------------------------
x1=-1:0.01:1;	% the semi-colon at the end prevents the echo 
x2=-1:0.01:1;	% these are also the side constraints
% x1 and x2 are vectors filled with numbers starting
% at 0 and ending at 10.0 with values at intervals of 0.1

[X1 X2] = meshgrid(x1,x2);
% generates matrices X1 and X2 correspondin
% vectors x1 and x2

% filled contour with default colormap
% help graph3d gives you the choices for colormap
f1 = obj_ex2(X1,X2);% the objecive function is evaluated over the entire mesh
[C1,h1] = contourf(x1,x2,f1,...
   [0 0.1 0.3 0.6 0.8 1.0 1.2 1.5 1.8 2.0 2.2 2.4 2.6 2.8 3.0]);
clabel(C1,h1);
colorbar  % illustrates the scale
grid
set(gca,'xtick',[-1 -0.5 0.0 0.5 1.0])
set(gca,'ytick',[-1 -0.5 0.0 0.5 1.0])
grid
xlabel(' x_1 values','FontName','times','FontSize',12);	% label for x-axes
ylabel(' x_2 values','FontName','times','FontSize',12);
title({'Filled Labelled Contour','default color'}, ...
   'FontName','times','FontSize',10)
grid


% a new figue is used 
% basic contour plot superimposed with gradient information
% information is generated on a larger mesh to keep the 
% figure tidy. grid is removed for clarity

figure
y1 = -1:0.1:1.0;
y2 = -1:0.1:1;
[Y1,Y2] = meshgrid(y1,y2);
f2 = obj_ex2(Y1,Y2);
[C2,h2] = contour(y1,y2,f2,[0 0.5 0.75 1.0 1.5 1.75 2.0 2.5 2.5 3.0]);
clabel(C2,h2)
[GX, GY] = gradient(f2,0.2);
hold on 
quiver(Y1,Y2,GX,GY);
hold off
set(gca,'xtick',[-1 -0.5 0.0 0.5 1.0])
set(gca,'ytick',[-1 -0.5 0.0 0.5 1.0])
xlabel(' x_1 values','FontName','times','FontSize',12);	% label for x-axes
ylabel(' x_2 values','FontName','times','FontSize',12);
title({'2D Contour','with Gradient Vectors'}, ...
   'FontName','times','FontSize',10)




% this is a stacked contour map
figure
contour3(x1,x2, f1,[0 0.3 0.6 0.8 1.0 1.5 1.8 2.0 2.2 2.4 2.6 2.8 3.0]);
grid
set(gca,'xtick',[-1 -0.5 0.0 0.5 1.0])
set(gca,'ytick',[-1 -0.5 0.0 0.5 1.0])
% change color map set color bar
colormap(spring)
colorbar
xlabel(' x_1 values','FontName','times','FontSize',12);	% label for x-axes
ylabel(' x_2 values','FontName','times','FontSize',12)
title({'Stacked (3D) Contour','colormap - spring'}, ...
   'FontName','times','FontSize',10)

grid

% a mesh of the function
figure
colormap(cool)

mesh(y1,y2,f2)
set(gca,'xtick',[-1 -0.5 0.0 0.5 1.0])
set(gca,'ytick',[-1 -0.5 0.0 0.5 1.0])
colorbar
xlabel(' x_1 values','FontName','times','FontSize',12);	% label for x-axes
ylabel(' x_2 values','FontName','times','FontSize',12);
title({'Coarse Mesh Plot','colormap - cool'}, ...
   'FontName','times','FontSize',10)

grid


% surface plot with default colormap
figure
colormap(jet)
surf(y1,y2,f2)
grid
colorbar
set(gca,'xtick',[-1 -0.5 0.0 0.5 1.0])
set(gca,'ytick',[-1 -0.5 0.0 0.5 1.0])
title({'Coarse Surface Plot','colormap - jet/default'}, ...
   'FontName','times','FontSize',10)

grid


xlabel(' x_1 values','FontName','times','FontSize',12);	% label for x-axes
ylabel(' x_2 values','FontName','times','FontSize',12);

hold off

