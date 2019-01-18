% Example 6.1 	
% Numerical Techniques for Unconstrained Optimization
% Optimzation with MATLAB, Section 6.1.1
% Dr. P.Venkataraman
%
%	

% symbolic calculation
syms xx1 xx2 ff gradx1 gradx2 hess
ff = 3 + (xx1 - 1.5*xx2)*(xx1 -1.5*xx2) + (xx2 -2 )*(xx2 - 2);

% gradients
gradx1 = diff(ff,xx1)
gradx2 = diff(ff,xx2)

% solution to FOC
optimum = solve(gradx1, gradx2)

fprintf('FOC --- \n')
fprintf('x1* = '),disp(double(optimum.xx1))
fprintf('x2* = '),disp(double(optimum.xx2))

% applying second order condition
fprintf('\n\nSOC -----')
hess=[diff(gradx1,xx1)  diff(gradx1,xx2); diff(gradx2,xx1) diff(gradx2,xx2)];
fprintf('\nHessian \n '),disp(hess)

% calculate eigen value
evalue = eig(hess);
fprintf('\neigen value \n'),disp(evalue)

% graphical optimization
x1=0:0.1:5;
x2 = 0:0.1:5;
[X1 X2] = meshgrid(x1,x2);


f = 3 +(X1 - 1.5*X2).*(X1 - 1.5*X2) + (X2-2).^2;

c1 = contour(x1,x2,f, ...
   [3.1 3.25 3.5 4 6 10 15 20 25],'k');
clabel(c1);
grid
xlabel('x_1')
ylabel('x_2')
title('Example 6.1')