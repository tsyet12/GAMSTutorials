function retval = Ofun(x)
% objective function
retval = x(1)^4 - 2*x(1)*x(1)*x(2) +x(1)*x(1) + x(1)*x(2)*x(2) -2*x(1) + 4;