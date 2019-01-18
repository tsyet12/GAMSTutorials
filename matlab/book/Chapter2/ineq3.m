function retval = ineq3(X1,X2)
% global statement is used to share same information between 
% various m-files
global ELAS SIGALL TAUALL GAM FS GRAV
global RHO CD FLAGW SPEED LP L DELT

AREA = 0.25* pi*(X1.^2 - X2.^2);
INERTIA = pi*(X1.^4 - X2.^4)/64;
FD = 0.5*RHO*SPEED*SPEED*CD.*X1;
dw = FD.*L^4./(8*ELAS.*INERTIA);
df = (2.0*FLAGW*L^3 - FLAGW*L*L*LP)./(ELAS*INERTIA);

retval = dw + df;