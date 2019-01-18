function [ret1, ret2] = ineq_ex4(X1,X2)
% returns both the inequality constraints
global N H K W AREA

c = 2*sqrt(2.0)*sqrt(H/K)*X2./sqrt(X1);

ret1 = (besseli(1,c)./((0.5*c).*besseli(0,c)));

Ac = 2.0*W*sqrt((X2.*X2 + .25*X1.*X1));
Ab = (N-1)*W*X2;
At = N*Ac + Ab;
Ar = Ac./At;

ret2 = (1.0 - N *Ar.*(1 - ret1));