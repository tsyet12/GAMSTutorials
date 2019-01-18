% 
% Optimization with MATAB; Dr P.Venkataramana=
% Chapter 7	Section 7.3.1
% Sequential Linear Programming - 
%   Generating plots for a chosen design vector
% Example 7.1
% Symbolic Calculations and plotting
% Two variable problem only
%
format compact
syms x1 x2 f g h 
syms gradf1 gradf2 gradh1 gradh2 gradg1 gradg2

f = x1^4 - 2*x1*x1*x2 + x1*x1 + x1*x2*x2 - 2*x1 + 4;
h = x1*x1 + x2*x2 - 2;
g = 0.25*x1*x1 +0.75*x2*x2 -1;

gradf1 = diff(f,x1);
gradf2 = diff(f,x2);
gradh1 = diff(h,x1);
gradh2 = diff(h,x2);
%gradg1 = diff(g,x1);
%gradg2 = diff(g,x2);


string1 = ['Input the design vector:  '];    
xb = input(string1)
fprintf('\n')

f1 = subs(f,{x1,x2},{xb(1),xb(2)})
g1 = subs(g,{x1,x2},{xb(1),xb(2)})
h1 = subs(h,{x1,x2},{xb(1),xb(2)})
gf1 =  double(subs(gradf1,{x1,x2},{xb(1),xb(2)}))
gf2 =  double(subs(gradf2,{x1,x2},{xb(1),xb(2)}))
gh1 =  double(subs(gradh1,{x1,x2},{xb(1),xb(2)}))
gh2 =  double(subs(gradh2,{x1,x2},{xb(1),xb(2)}))
%gg1 =  double(subs(gradg1,{x1,x2},{xb(1),xb(2)}))
%gg2 =  double(subs(gradg2,{x1,x2},{xb(1),xb(2)}))


% choose values for rh and rg

x11 = -5:.2:5;
x22 = -5:.2:5;
x1len = length(x11)
x2len = length(x22)
for i = 1:x1len;
   for j = 1:x2len;
      xbv = [x11(i) x22(j)];
      fnew(j,i) = f1 + [gf1 gf2]*xbv';
      hnew(j,i) = h1 + [gh1 gh2]*xbv';
      %gnew(j,i) = g1 + [gg1 gg2]*xbv';
   end
end

minf = min(min(fnew));
maxf = max(max(fnew));
mm = (maxf - minf)/5.0;
mvect=[(minf+mm) (minf + 1.5*mm) (minf + 2*mm) (minf+ 2.5*mm) (minf + 3.0*mm) (minf +4*mm) (minf + 4.5*mm)];
[c1,fc] = contour(x11,x22,fnew,mvect,'b');
clabel(c1);
set(fc,'LineWidth',2)
grid
xlabel('\delta x_1')
ylabel('\delta x_2')
title('Example 7.1: Sequential Linear Programming')

hold on

[c2,hc]=contour(x11,x22,hnew,[0,0],'r');
set(hc,'LineWidth',2,'LineStyle','--')
grid

%[c3,gc]=contour(x11,x22,gnew,[0,0],'r');
%set(gc,'LineWidth',2,'LineStyle',':')
%contour(x11,x22,gnew,[1,1],'k')
grid
hold off