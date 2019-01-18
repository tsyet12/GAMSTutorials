function ret = eqns4_4_2(x)

% x is a vector
% x(1) = x1, x(2) = x2, x(3) = lam1
ret=[(-x(2) + 0.5*x(1)*x(3)), ...
      (-x(1) + 2*x(2)*x(3)), ...
      (0.25*x(1)*x(1) + x(2)*x(2) -1)];