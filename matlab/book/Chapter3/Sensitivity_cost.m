% Sesisitivity to Cost coefficient
%  Optimization Using MATLAB by P.Venkataraman
%	Ch. 3
%	Using drawLine.m 
%
clf
drawLine(0,15,0.4,0.6,8.8,'l');
drawLine(0,15,3,-1,25,'l');
drawLine(0,15,3,6,70,'l');
drawLine(0,15,-990,-900,-16150,'n');
xlabel('Machines of Type A');
ylabel('Machines of Type B');
title('Sensitivity to Cost Coeff.')
h1 = text(5,-25,'c1 = -990 - original');
plot(10.47,6.42,'bo')
grid

pause(5)

delete(h1);
h21= drawLine(0,15,-1900,-900,-16150,'n');

h1 = text(5,-25,'c1 = -1900 - optimum unchanged');
grid

pause(5)
delete(h1)
delete(h21)
drawLine(0,15,-200,-900,-16150,'n');
h1 = text(5,-25,'c1 = -200 - optimum changed');
grid


