% Example 8.2: 
% Chapter 8: Discrete Optimization
%
% Applied Optimization with MATLAB
% P.Venkataraman
% Published by John Wiley
% 
% Branch and Bound
% Min: f(x1,x2) = (x1 -15)^2 + (x2 - 15)^2
% Subject: g1 -> x1 + x2 <= 26
%			  g2 -> x1 + 2.5*x2 <= 37
% Discrete Variable : x1 -> integers between [10 11 12 13]
%                     x2 -> integers between [9 10 11 12]
%-------------------------------------------------------------
format compact
clear

fprintf('both variables free -continuous relaxation\n')
fprintf('Choose BEST FEASIBLE solution from the following cases\n')

% continuous analytical solution
syms x1 x2 f g1 g2 F beta1 beta2
f = (x1 -15)^2 + (x2 - 15)^2;
g1 = x1 + x2 - 26;
g2 = x1 + 2.5*x2 - 37;
F = f + beta1*g1 + beta2*g2;

gradF1 = diff(F,x1);
gradF2 = diff(F,x2);

% case a : beta1 = 0; beta2 = 0
beta1 = 0; beta2 = 0;
[x1s x2s] = solve(gradF1,gradF2,'x1,x2');
x1 = double(subs(x1s));
x2 = double(subs(x2s));
g1a = subs(g1);
g2a = subs(g2);
f1a = subs(f);
xstar = [x1 x2];
fprintf('\nCase a - beta1 = 0, beta2 = 0\n')
fprintf('-----------------------------\n')
fprintf('optimal number of pizzas : '),disp(xstar)
fprintf('Minimum cost of pizzas : '),disp(f1a)
fprintf('Constraint g1 : '),disp(g1a)
fprintf('Constraint g2 : '),disp(g2a)

% case b: beta1 = 0, g2 = 0
beta1 = 0; 
[beta2s x1s x2s ] = solve(gradF1,gradF2,g2,'x1,x2,beta2');
x1 = double(subs(x1s));
x2 = double(subs(x2s));
beta2 = double(subs(beta2s));
g1a = subs(g1);
g2a = subs(g2);
f1a = subs(f);
xstar = [x1 x2];

fprintf('\nCase b - beta1 = 0, g2 = 0\n')
fprintf('-----------------------------\n')

fprintf('optimal number of pizzas : '),disp(xstar)
fprintf('Lagrange multiplier - beta2 : '),disp(beta2)
fprintf('Minimum cost of pizzas : '),disp(f1a)
fprintf('Constraint g1 : '),disp(g1a)
fprintf('Constraint g2 : '),disp(g2a)

% case c: g1 = 0, beta2 = 0
beta2 = 0; 
[beta1s x1s x2s ] = solve(gradF1,gradF2,g1,'x1,x2,beta1');
x1 = double(subs(x1s));
x2 = double(subs(x2s));
beta1 = double(subs(beta1s));
g1a = subs(g1);
g2a = subs(g2);
f1a = subs(f);
xstar = [x1 x2];

fprintf('\nCase c - g1 = 0, beta2 = 0\n')
fprintf('-----------------------------\n')

fprintf('optimal number of pizzas : '),disp(xstar)
fprintf('Lagrange multiplier - beta1 : '),disp(beta1)
fprintf('Minimum cost of pizzas : '),disp(f1a)
fprintf('Constraint g1 : '),disp(g1a)
fprintf('Constraint g2 : '),disp(g2a)

% case d: g1 = 0, g2 = 0

[beta1s beta2s x1s x2s ] = solve(gradF1,gradF2,g1,g2,'x1,x2,beta1,beta2');
x1 = double(subs(x1s));
x2 = double(subs(x2s));
beta1 = double(subs(beta1s));
beta2 = double(subs(beta2s));
g1a = subs(g1);
g2a = subs(g2);
f1a = subs(f);
xstar = [x1 x2];

fprintf('\nCase d - g1 = 0, g2 = 0\n')
fprintf('-------------------------\n')

fprintf('optimal number of pizzas : '),disp(xstar)
fprintf('Lagrange multiplier - beta1 : '),disp(beta1)
fprintf('Lagrange multiplier - beta2 : '),disp(beta2)
fprintf('Minimum cost of pizzas : '),disp(f1a)
fprintf('Constraint g1 : '),disp(g1a)
fprintf('Constraint g2 : '),disp(g2a)
clear
pause(2)
%-----------------------------------------------
% x1 is held at discrete values
% x2 is computed analytically - is allowed to be continuous
% There are 4 cases - 
% The last case bet1 = 0 and bet2 = 0 is not possible 
% for the selected discrete value of x1
% it is possible to automatically return
% the best feasible solutiion for each discrete value of x1

fprintf('\n\n\nx1 is discrete x2 is free -continuous relaxation\n')
fprintf('For each discrete value for x1 \n')
fprintf('Choose BEST FEASIBLE solution from the following cases\n')



bv = [10 11 12 13];
%syms ff x2 bet1 bet2 FF
for i = 1:length(bv)
   syms ff x2 bet1 bet2 FF
   x1d = bv(i);
   ff = (x1d - 15)^2 + (x2 - 15)^2;
   gg1 = x1d + x2 -26;
   gg2 = x1d + 2.5*x2 -37;
   FF = ff + bet1*gg1 + bet2 * gg2;
   gradFF2 = diff(FF,x2);
   
   % case(a): bet1 =0; bet2 = 0
   x2 = 15;
   bet1 = 0; bet2 = 0;
   f = double(subs(ff));
   g1 = double(subs(gg1));
   g2 = double(subs(gg2));
   x = [x1d x2];
   beta =[0 0];
   fg=[f g1 g2];
   fprintf('\nCase a - bet1 = 0, bet2 = 0\n')
   fprintf('-------------------------\n')  
   fprintf('optimal number of pizzas : '),disp(x)
   fprintf('Lagrange multiplier - beta : '),disp(beta)
   fprintf('f g1 g2 : '),disp(fg)
   
   syms ff x2 bet1 bet2 FF
   x1d = bv(i);
   ff = (x1d - 15)^2 + (x2 - 15)^2;
   gg1 = x1d + x2 -26;
   gg2 = x1d + 2.5*x2 -37;
   FF = ff + bet1*gg1 + bet2 * gg2;
   gradFF2 = diff(FF,x2);
   
   % case(b): bet1 =0; g2 = 0
   
   bet1 = 0;
   [bet2 x2] = solve(gradFF2,gg2,'bet2,x2');
   x2 = double(subs(x2));
   bet2 = double(subs(bet2));
   f = double(subs(ff));
   g1 = double(subs(gg1));
   g2 = double(subs(gg2));
   x = [x1d x2];
   beta =[0 bet2];
   fg=[f g1 g2];
   fprintf('\nCase b - bet1 = 0, g2 = 0\n')
   fprintf('-------------------------\n')  
   fprintf('optimal number of pizzas : '),disp(x)
   fprintf('Lagrange multiplier - beta: '),disp(beta)
   fprintf('f g1 g2 : '),disp(fg)

   % case(c): g1 =0; bet2 = 0
   
   bet2 = 0;
   [bet1 x2] = solve(gradFF2,gg1,'bet1,x2');
   x2 = double(subs(x2));
   bet1 = double(subs(bet1));
   f = double(subs(ff));
   g1 = double(subs(gg1));
   g2 = double(subs(gg2));
   x = [x1d x2];
   beta =[bet1 0];
   fg=[f g1 g2];
   fprintf('\nCase c - g1 = 0, bet2 = 0\n')
   fprintf('-------------------------\n')  
   fprintf('optimal number of pizzas : '),disp(x)
   fprintf('Lagrange multiplier - beta: '),disp(beta)
   fprintf('f g1 g2 : '),disp(fg)

end
fprintf('\n\nboth variables are discrete - enumerate all cases\n')
fprintf('Choose BEST FEASIBLE solution from the following matrices\n')


% the following are the computation for all combination of 
% discret variables x1 and x2
clear
bv = [10 11 12 13];
cv = [9 10 11 12];
for i = 1:length(bv)
   x1 = bv(i);
   for j = 1:length(cv)
      x2 = cv(j);
      fmat(i,j) = (x1 - 15)^2 + (x2 - 15)^2;
      g1mat(i,j) = x1 + x2 -26;
      g2mat(i,j) = x1 + 2.5*x2 -37;
   end
end
fprintf('\nAll discrete combinationns\n')
fprintf('-------------------------\n') 
fprintf('Discrete Varible x1 Values \n'),disp(bv)
fprintf('Discrete Varible x2 Values \n'),disp(cv)
fprintf('optimal cost \n'),disp(fmat)
fprintf('Inequality constraint 1 \n'),disp(g1mat)
fprintf('Inequality constraint 2 \n'),disp(g2mat)

      