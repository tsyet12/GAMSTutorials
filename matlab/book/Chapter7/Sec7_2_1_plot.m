% 
% Optimization with MATAB; Dr P.Venkataramana=
% Chapter 7	Section 7.2.1
% External Penalty Function Method
% Example 7.1
% Symbolic Calculations and plotting
format compact
syms x1 x2 rh rg f g h F grad1 grad2

f = x1^4 - 2*x1*x1*x2 + x1*x1 + x1*x2*x2 - 2*x1 + 4;
h = x1*x1 + x2*x2 - 2;
g = 0.25*x1*x1 +0.75*x2*x2 -1;
%F = f + rh*h*h + rg*g*g;
%grad1 = diff(F,x1);
%grad2 = diff(F,x2);

% choose values for rh and rg
rh = 5; rg = 5;

x11 = -2:.2:5;
x22 = -2:.2:5;
x1len = length(x11);
x2len = length(x22);
for i = 1:x1len;
   for j = 1:x2len;
      gval = subs(g,{x1 x2},{x11(i) x22(j)});
      if gval < 0
         gval = 0;
      end
      hval = subs(h,{x1 x2},{x11(i) x22(j)});
      
      Fval(j,i) = subs(f,{x1 x2},{x11(i) x22(j)}) ...
         + rg*gval*gval + rh*hval*hval;
   end
end

c1 = contour(x11,x22,Fval,[3.1 4 5 6 10 20 50 100 200 500]);
clabel(c1);
grid
xlabel('x_1')
ylabel('x_2')
strng = strcat('Example 7.1: ','r_h =   ', num2str(rh),'r_g =  ',num2str(rg));

title(strng)
