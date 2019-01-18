function retval = f_ex71(X,Y)
%  returns the equality cnstraint values
retval =X.^4 -2*(X.^2).*Y +  X.*X + X.*Y.*Y -2*X +4;