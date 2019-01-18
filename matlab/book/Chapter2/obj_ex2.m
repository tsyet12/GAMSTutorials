function retval = obj_ex1(X1,X2)
% Optimization with Matlab
% Dr. P.Venkataraman
% Chapter 2. Example 2
% Problem appeared in Reference 2.3
%
%	f(x1,x2) = a*x1^2 + b*x2^2 -ccos(aa*x1)-d*cos(bb*x2) + c + d
a = 1; b = 2; c = 0.3; d = 0.4; aa = 3.0*pi; bb = 4.0*pi;
retval = a*X1.*X1 + b*X2.*X2 -c*cos(aa*X1) - ...
   d*cos(bb*X2) + c + d;