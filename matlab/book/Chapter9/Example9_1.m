function retval = Example9_1(x)
% example 9.1
R = sqrt((x(1)-4)^2 + (x(2)-4)^2 + 0.1);  
% to prevent division by zero
% this is not actually the sinc function
retval = -20*sin(R)/R;


