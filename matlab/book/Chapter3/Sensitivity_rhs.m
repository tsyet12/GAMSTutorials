%  Sensitivity to right hand side coefficient
%  Optimization Using MATLAB by P.Venkataraman
%	Ch. 3
%	Using drawLine.m 
%
clf
drawLine(0,15,0.4,0.6,8.5,'l');
drawLine(0,15,3,-1,25,'l');
drawLine(0,15,3,6,70,'l');
drawLine(0,15,-990,-900,-16150,'n');
xlabel('Machines of Type A');
ylabel('Machines of Type B');
title('Sensitivity to resource limits.')
h1 = text(5,-25,'b1 = 8.5  - original');
plot(10.47,6.42,'bo')

grid


pause(5)
delete(h1)
h21 = drawLine(0,15,0.4,0.6,10.5,'l');
h1 = text(5,-25,'b1 = 10.5 - optimum unchanged');
grid

pause(5)
delete(h1);
delete(h21);
h21= drawLine(0,15,0.4,0.6,6.5,'l');

h1 = text(5,-25,'b1=6.5 - optimum changed - active constraint');
grid



