% Example 4.2	Unconstrained Optimization
%
% Optimzation with MATLAB, Section 4.5.1
% Dr. P.Venkataraman
% Linear curve fitting
% 20 data points are generated using the 
% uniformly distributed random number function --rand
% and the function z = 0.5 y^2
%
n = 20; % number of data points
rn = rand(n); % creates a 20 * 20 matrix of random numbers
yi = 5*rn(1,:); % create the value yi between 0 and 5
%                 using the first row of random matrix

zi = 0.5*yi.^2;

% ----- the data points have been generated

% generates the Left hand side matrix
A =[sum(yi.*yi) sum(yi); sum(yi) n];
b = [sum(zi.*yi) ; sum(zi)]; % the right hand side vector

% obtain the design variables
X = inv(A)*b;

zp = X(1)*yi + X(2);% the fitted value
delz = zi - zp; % error in fit

f = sum(delz.*delz) % objective function

plot(yi,zi,'ro',yi,zp,'b-')% compare the data sets

xlabel('y values')
ylabel('z values')
title('Linear Fit')
grid

% print results to the screen
clc % clears command window

fprintf('Results from Linear fit \n')
fprintf('objective function:'),disp(f)
fprintf('design variables x1, x2:\n'),disp(X)
fprintf('\n      yi        zi       zp         diff \n')
disp ([yi' zi' zp' delz'])

% SOC - eigenvalues of A

fprintf('eigenvalues of Matrix A:\n'),disp(eig(A))
