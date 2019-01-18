% Example 8.2: 
% Chapter 8: Discrete Optimization
%
% Applied Optimization with MATLAB
% P.Venkataraman
% Published by John Wiley
% 
% Exhaustive Enumeration
% Min: f(x1,x2) = (x1 -15)^2 + (x2 - 15)^2
% Subject: g1 -> x1 + x2 <= 26
%				g2 -> x1 + 2.5*x2 <= 37
%
% Discrete Variable : x1 -> integers between 0 and 30
%                     x2 -> integers between 0 and 30
%-------------------------------------------------------------
format compact
clear

% establish the set of discrete variables
for i = 1: 31
   Yd1(i) = i-1;
   Yd2(i) = i-1;
end

% a faster computational strategy is to compute
% the objective function and constraints 
% as a matrices using m-files  which is done 
% during the graphical definition of the problem

% the following follows Algorithm 8.1 quite clearly

fstar = inf;
xstar = [0 0];
for i = 1:length(Yd1)
   for j = 1:length(Yd2)
      f = (Yd1(i)-15)^2 +(Yd2(j) - 15)^2;
      g1 = Yd1(i) + Yd2(j)-26;
      g2 = Yd1(i) + 2.5*Yd2(j) -37;
      
      if (g1 <= 0) & (g2 <= 0) & (f < fstar)
         g1star = g1;
         g2star = g2;
         fstar = f;
         xstar = [Yd1(i) Yd2(j)];
      end
   end
end
fprintf('optimal number of pizzas : '),disp(xstar)
fprintf('Minimum cost of pizzas : '),disp(fstar)
fprintf('Constraint g1 : '),disp(g1star)
fprintf('Constraint g2 : '),disp(g2star)

% graphical solution to the problem
% requires files obj8_2.m, g18_2.m, g28_2.m
% this is possible for a two variable model

p1 = -1 : 0.5: 40;
p2 = -1 : 0.5: 40;
[P1 P2] = meshgrid(p1,p2);
obj = obj8_2(P1,P2);
ineq1 = g18_2(P1,P2);
ineq2 = g28_2(P1,P2);
[C1 h1] = contour(p1,p2,obj,[ 0 5 10 20 34 50 100 150 200],'g');
hold on
contour(p1,p2,ineq1,[ 0 0],'k-');
contour(p1,p2,ineq2,[ 0 0],'k--');
xlabel('pepperoni pizza')
ylabel('cheese pizza')
title('Example 8.2')
grid
hold off

      
      
