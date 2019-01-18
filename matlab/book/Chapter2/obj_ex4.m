function retval = obj_ex4(X1,X2)
% volume of the fin
global N H K W AREA
%retval = 0.433*N*X1.*X1.*X2;
 retval = 0.5*N*W*X1.*X2;