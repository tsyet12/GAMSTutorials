function ret = objective(x)

% this sets up the objective function
global rho L W E sigy tauy


area = 2*x(2)*x(4)+ x(1)*x(3) - 2*x(3)*x(4);
ret = rho*L*area;