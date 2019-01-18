function [c, ceq] = nonlin_cons(x)
global rho L W E sigy tauy

% set up the nonlinear constraints
% nonlinear inequality constraints returned as vector c
inertia = (x(2)*x(1)^3/12) -(x(2)-x(4))*(x(1)-2*x(3))^3/12;
qc = 0.5*x(2)*x(4)*(x(1)-x(4))+ 0.5*x(3)*(x(1)-x(4))^2;

g1 = W*L^3 -12*E*inertia;
g2 = W*L*x(1) - 8*inertia*sigy;
g3 = W*qc - 2*inertia*x(3)*tauy;

c = [g1 g2 g3];
% nonlinear equality constraints returned as vector ceq

ceq = []; % there are no nonlinear equality 
				% constraints in this problem