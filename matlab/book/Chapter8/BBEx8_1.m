% Example 8.1: 
% Chapter 8: Discrete Optimization
%
% Applied Optimization with MATLAB
% P.Venkataraman
% Published by John Wiley
%
% Min: f(x1,x2,x3) = (x1 -2)^2 + (x1 - x2)^2 + (x1 - x3)^2 +(x2 - x3)^2
%
% Continous variable: x1
% Discrete Variable : x2 -> [0.5 1.5 2.5 3.5]
%                     x3 -> [0.25 0.75 1.75 2.25 2.75]
% Calculations for Branch and Bound
%-------------------------------------------------------------
format compact
clear

% Using symbolic calculations
syms x1 x2 x3 bv cv;

a = 2;
bv = [0.5 1.5 2.5 3.5];
cv = [0.22 0.75 1.73 2.24 2.78];

f = (x1 -a)^2 + (x1 - x2)^2 + (x1 - x3)^2 +(x2 - x3)^2;

% the problem is formulated such that the unconstrained solution 
% at x1* = 2 = x2* = x3* and f* = 0

% technically the kuhn tucker condition
gradx1 = diff(f,x1);
gradx2 = diff(f,x2);
gradx3 = diff(f,x3);

[yc1 yc2 yc3] =solve(gradx1,gradx2,gradx3,'x1,x2,x3');
fprintf('Continuous optimal solution\n')
fprintf('---------------------------\n')
x1 = double(yc1); x2 = double(yc2); x3 = double(yc3);

fprintf('x1* = %6.2f\n',x1)
fprintf('x2* = %6.2f\n',x2)
fprintf('x3* = %6.2f\n',x3)

fc = subs(f);
fprintf('f* = %6.2f\n',fc)

% establishing first tier nodes - 1,2,3,4
for i = 1:length(bv)  
      x2 = bv(i);
 
      % to save computation time symbolic computation
      % can be avoided by solving numerically - not done here
      [x1 x3]= solve(gradx1,gradx3,'x1,x3');
      x1 = double(subs(x1));
      x3 = double(subs(x3));
      fx1(i) = double(subs(f));
      x1x(i) = x1;
      x3x(i)= x3;
end

fprintf('\nDiscrete Optimization: Branch and Bound\n')
fprintf('only x2 varying              -------------\n')
for i = 1:length(bv)
   xdes = double([x1x(i) bv(i) x3x(i)]);
   fprintf('design variable: \n'),disp(xdes)
   fprintf('objective function: \n'),disp(fx1(i))
end



fprintf('\nnDiscrete Optimization: Branch and Bound\n')
fprintf('Both discrete variables varying      ------\n')

for i = 1:length(bv)
   for j = 1:length(cv)
      x2 = bv(i);
      x3 = cv(j);
      % to save computation time symbolic computation
      % can be avoided by solving numerically - not done here
      x1 = subs(solve(gradx1,'x1'));
      %x1 = subs(xx);
      fex(i,j) = subs(f);
      x1ex(i,j) = x1;
      
   end
end
fprintf('discrete variable x2: \n'),disp(bv)
fprintf('discrete variable x3: \n'),disp(cv)


fprintf(['optimal value of continuous variable x1:' ...
   '\nfor each combination of discrete variable\n']),disp(x1ex)

fprintf(['\noptimal value of objective function:' ...
   '\nfor each combination of discrete variable\n']),disp(fex)



