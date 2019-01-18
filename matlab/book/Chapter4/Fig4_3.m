% Illustration of the gradient for two variables
%  Optimization Using MATLAB
%	Dr. P.Venkataraman
%
%	section 4.2.2
% The graphics are generated in the code
% Some annotations are performed using editing
% commands from the menu bar in figure window

x=0:.05:3;	
y=0:0.05:3;
[X Y]=meshgrid(x,y); % X,Y are matrices

fval=0.25*X.*X + Y.*Y -1;	% could have used an m-file

subplot(2,1,1) % divides figure window into 2 rows
% and addresses top row

[c1,h1]= contour3(x,y,fval,[0 1 2 3]);
% draws the specified contour in 3D
% and establishes handles to set properties of plot               
set(h1,'LineWidth',2);
clabel(c1);	% labels contours
xlabel('x');
ylabel('y');
title('3D contour for f(x,y) = x^2/4 + y^2 -1');

% swithches to second row (lower plot)
subplot(2,1,2)
[c2,h2]=contour(x,y,fval,[0 1 2 3]);
set(h2,'LineWidth',2);
clabel(c2)
xlabel('x');
ylabel('y');
grid

% processing using the symbolic toolbox

% identify a point on contour f = 0
xf0 = 1.0;  % x-value of point
syms f xx yy;
f=0.25*xx*xx + yy*yy -1; % the contour f=0
fy0=subs(f,xx,xf0); % substitute for x
yf0=solve(fy0,yy);  % solve for y value of point
yf0d=double(yf0(1)); % express it as a decimal

% identify a point on contour f = 2
xf2 = 2.0; % x-value of point
sym fxy2;
fxy2=0.25*xx*xx + yy*yy -1-2; % contour f = 2

fy2=subs(fxy2,xx,xf2); % substitute for x
yf2=solve(fy2,yy);
yf2d=double(yf2(1));  % decimal value for y value 

% draw  blue line connecting the two points in both plots
% line PQ in Figure 4.3
subplot(2,1,1)
line([xf0 xf2],[yf0d yf2d],[0 2],'Color','b', ...
      'LineWidth',2);

subplot(2,1,2)
line([xf0 xf2],[yf0d yf2d],'Color','b','LineWidth',2);

% the value of f at the point R in the Figure 4.3
fxy02=subs(f,{xx,yy},{xf2,yf0d});

% Line PR in Figure 4.3
line([xf0 xf2],[yf0d yf0d],'Color','g', ...
   'LineWidth',2,'LineStyle','--')
% Line RQ in Figure 4.3
line([xf2 xf2],[yf0d yf2d],'Color','g', ...
   'LineWidth',2,'LineStyle','--')

axis square	% this is useful for identfing tangent 
%              and gradient
