%  Sensitivity to coefficients
%  Optimization Using MATLAB by P.Venkataraman
%	Ch. 3
%	Using drawLine.m 
%
clf
h21 = drawLine(0,15,0.4,0.6,8.5,'l');
drawLine(0,15,3,-1,25,'l');
drawLine(0,15,3,6,70,'l');
drawLine(0,15,-990,-900,-16150,'n');
xlabel('Machines of Type A');
ylabel('Machines of Type B');
title('Sensitivity to constraint coefficients (a11).')
h1 = text(5,-25,'a11 = 0.4  - original');
plot(10.47,6.42,'bo')

grid


pause(5)
delete(h1)
delete(h21)
h21 = drawLine(0,15,0.2,0.6,8.5,'l');
h1 = text(5,-25,'a11 = 0.4 - optimum unchanged');
grid

pause(5)
delete(h1);
delete(h21);
h21= drawLine(0,15,0.6,0.6,8.5,'l');

h1 = text(5,-25,'a11=0.6 - optimum changed');
grid



