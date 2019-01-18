x=0:.05:3;
y=0:0.05:3;
[X Y]=meshgrid(x,y);
%fval=f42(X,Y);
fval=0.25*X.*X + Y.*Y -1;

subplot(2,1,1)
[c1,h1]= contour3(x,y,fval,[0 1 2 3]);
set(h1,'LineWidth',2);
clabel(c1);
xlabel('x');
ylabel('y');
title('3D contour for f(x,y) = x^2/4 + y^2 -1');
subplot(2,1,2)
[c2,h2]=contour(x,y,fval,[0 1 2 3]);
set(h2,'LineWidth',2);
clabel(c2)
xlabel('x');
ylabel('y');
%text(0.5,2.5,'2D contour');
grid

% identify a point on contour f = 0
xf0 = 1.0;
syms f xx yy;
f=0.25*xx*xx + yy*yy -1;
fy0=subs(f,xx,xf0);
yf0=solve(fy0,yy);
yf0d=double(yf0(1));

% identify a point on contour f = 2
xf2 = 2.0;
sym fxy2;
fxy2=0.25*xx*xx + yy*yy -1-2;

fy2=subs(fxy2,xx,xf2);
yf2=solve(fy2,yy);
yf2d=double(yf2(1));

% draw line in both plots
subplot(2,1,1)
line([xf0 xf2],[yf0d yf2d],[0 2],'Color','b','LineWidth',2);

subplot(2,1,2)
line([xf0 xf2],[yf0d yf2d],'Color','b','LineWidth',2);

fxy02=subs(f,{xx,yy},{xf2,yf0d});
line([xf0 xf2],[yf0d yf0d],'Color','g', ...
   'LineWidth',2,'LineStyle','--')
line([xf2 xf2],[yf0d yf2d],'Color','g', ...
   'LineWidth',2,'LineStyle','--')

%funct=0.25*X.*X + Y.*Y -1;
%[px,py]=gradient(funct,0.5,0.5);
%subplot(2,1,1)
%quiver(px,py)
axis square
