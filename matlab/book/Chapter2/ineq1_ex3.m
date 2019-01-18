function retval = ineq1_ex3(X1,X2)
% global statement is used to share same information between 
% various m-files
global ELAS SIGALL TAUALL GAM FS GRAV
global RHO CD FLAGW SPEED LP L DELT

AREA = 0.25* pi*(X1.^2 - X2.^2); % matrix
INERTIA = pi*(X1.^4 - X2.^4)/64;
FD = 0.5*RHO*SPEED*SPEED*CD*X1;
MW = 0.25*FD*L*L.*X1./INERTIA;
MF = 0.5*FLAGW * LP*X1./INERTIA;

SIGW = GAM*GRAV*L;

retval = MW + MF + SIGW;% SIGW is added to all matrix elements

