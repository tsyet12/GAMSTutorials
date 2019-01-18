function stst = state(t,y) 
% set up the state equations as a col vector 
% the previous state is known in y 
% the first order derivatives is returned 
% in the variable name used to the left 
% of the equal sign 
stst = [ y(2) , y(3) , -0.5*y(1)*y(3)]'; 