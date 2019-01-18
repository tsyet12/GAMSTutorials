%  Applied Optimization with MATLAB
%  Chapter 7, Section 7.3
%  Example of linearization
%  Graphical representation of Example 4.1
clf
% draw the contour of f
x1=-2:0.1:5;
x2=-2:0.1:5;
[X1,X2]=meshgrid(x1,x2);

%h = h_ex71(X1, X2);
%g = g_ex71(X1, X2);
f = f_ex71(X1, X2);

%[c1,h1]=contour(x1,x2,h,[0,0],'k');
%set(h1,'LineWidth',2)

%[c2,g1]=contour(x1,x2,g,[0,0],'r');
%set(g1,'LineWidth',2)

[c3,f1]=contour(x1,x2,f,[3 3.1 3.5 7 10 20 64 100 200],'b');
set(f1,'LineWidth',2)
%clabel(c3,f1)
l1 = line([-2 5],[ 0 0]);
set(l1,'Color','m','LineStyle','--','LineWidth',2)

l2 = line([0 0],[-2 5]);
set(l2,'Color','m','LineStyle','--','LineWidth',2)
%axis square
grid
xlabel('x_1')
ylabel('x_2')
title('Example 7.1')
hold on
plot(3,2,'ro')

%  lenearization about x1 = 3, x2 = 2
%
syms f x1 x2 gradx1 gradx2 x1d x2d hess
f = x1^4 -2*x1*x1*x2 + x1*x1 + x1*x2*x2 - 2*x1 + 4;
gradx1 = diff(f,x1);
gradx2 = diff(f,x2);
hess = [diff(gradx1,x1), diff(gradx1,x2); diff(gradx2,x1), diff(gradx2,x2)];
fquad = subs(f,{x1,x2},{3,2}) + subs(gradx1,{x1,x2},{3,2})*x1d +subs(gradx2,{x1,x2},{3,2})*x2d + ...
   0.5*[x1d x2d]*subs(hess,{x1,x2},{3,2})*[x1d x2d]';

x11 = -2:.2:5;
x22 = -2:.2:5;
x1len = length(x11);
x2len = length(x22);
for i = 1:x1len;
   for j = 1:x2len;
            
      Fval(j,i) = subs(fquad,{x1d x2d},{x11(i) x22(j)});
   end
end

[c1,fl1] = contour(x11,x22,Fval,[5 10 15 20 50 100 200 300 500 800 1000],'r');
set(fl1,'LineWidth',2)
clabel(c1);
grid
hold off
