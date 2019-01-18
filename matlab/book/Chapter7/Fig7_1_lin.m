%  Applied Optimization with MATLAB
%  Chapter 7, Section 7.1
%  Example 7.1
%  Graphical representation of Example 4.1
clf
% draw the ellipse
x1=-2:0.1:4;
x2=-2:0.1:4;
[X1,X2]=meshgrid(x1,x2);

h = h_ex71(X1, X2);
%g = g_ex71(X1, X2);
f = f_ex71(X1, X2);

[c1,h1]=contour(x1,x2,h,[0,0],'k');

set(h1,'LineWidth',2)
hold on

%[c2,g1]=contour(x1,x2,g,[0,0],'r');
%set(g1,'LineWidth',2)

[c3,f1]=contour(x1,x2,f,[2.05 3 3.1 3.25 3.5 4 5 7 10 15 20 50],'b');
set(f1,'LineWidth',2)
%clabel(c3,f1)
l1 = line([-2 4],[ 0 0]);
set(l1,'Color','m','LineStyle','--','LineWidth',2)

l2 = line([0 0],[-2 4]);
set(l2,'Color','m','LineStyle','--','LineWidth',2)
axis square
grid
xlabel('x_1')
ylabel('x_2')
title('Example 7.1')
hold off