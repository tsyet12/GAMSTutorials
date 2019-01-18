% Unconstrained Optimization%  
%	Dr. P.Venkataraman
%
%	section 4.4.1, Figure 4.9
% additional graphics through plotedit
%

x1=0:.05:4;	
x2=0:0.05:4;
[X1 X2]=meshgrid(x1,x2); % X,Y are matrices

fval=(X1-1).^2 +(X2-1).^2 -X1.*X2;	% could have used an m-file

colormap(gray)    % sets the default colors
meshc(X1,X2,fval) % draws a mesh with contours underneath

rotate3d  % allows you to interactively rotate the figure
%				for better view
xlabel('x_1');
ylabel('x_2');
zlabel('f(x_1,x_2)')

% adds a tangent (plane) surface at the minimum
patch([1 3 3 1], [1 1 3 3],[-2 -2 -2 -2],'y')
grid

