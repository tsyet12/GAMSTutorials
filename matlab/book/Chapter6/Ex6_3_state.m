function stst = Ex6_3_state(t,y) 
% set up the state equations as a col vector 
% the previous state is known in y 
% the first order derivatives is returned 
% in the variable name used to the left 
% of the equal sign 
stst = [ y(2) , (y(1)*y(1)+y(2)*y(5)- y(3)*y(3)) ,...
      y(4), (2*y(1)*y(3) +y(4)*y(5)), -2*y(1)]'; 