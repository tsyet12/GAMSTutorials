% Applied Optimization with MATLAB
% P.Venkataraman
% Published by John Wiley
% Chapter 8: Discrete Optimization
% Section 8.2.3 Dynamic Programming
% Example 8.3: 
% Example of Faculty hiring
% Evaluating the cost for the model
%-------------------------------------------------
format compact
clear
clc
% problem data - Table 8.3 -----------------------
fac = [5 10 8 2]; % faculty required
hir = [10 10 10 10]; % hiring cost
ucost = [1 2 2 1];    % unit cost for each faculty
retain = [2 2 2 2];  % retaining cost for each faculty

%------------------------------------------------------
ns = 5; 	% number of states
c = zeros(ns,ns);  % initialization of cost for various 
%                     pairs of nodes
%                     for drawing digraphs

for i = 1:ns-1
   for j = i + 1 : ns
      fc = 0.0;   % number of faculty
     
      for k = i:j-1
         fc = fc + fac(k);
      end
      rcall = 0;
      for m = i:j-2
         rc = 0.0;    % retaining cost
         for n = m+1:j-1
            rc = rc + fac(n);
         end
         rcall = rcall + rc*retain(m); % total retaining cost
      end
      c(i,j) = hir(i)+fc*ucost(i) + rcall;
   end
end
fprintf('Example 8.3 : Dynamic Programming\n')
fprintf('Cost between pairs of nodes/states C(i,j)\n'), disp(c)
% the values in the diagraph are avialble in matrix c


% obtainng shortest path - no cylic paths
% the algorithm basically solves the functional 
% equations at each node

pathvalue(1) = 0.0;
addnode = zeros(ns,ns);  % if there are additional nodes
%									that give same optimal value

for i = 2:ns
   val = inf;   % initializing optimal value at node/state
   node = 0;    % tracking the  best node to reach here
   
   for j = i:-1:2
      value = pathvalue(j-1)+ c(j-1,i);
      if value < val         
         val = value ;
         node = j-1;
      end
      % if there are duplicate nodes for the optimal value
      if (value == val) & (node ~= j-1) 
            addnode(i,j)=j-1;
      end
   end
   pathvalue(i) = val;  % optimal value for this state
   nodevalue(i) = node;  % optimal node value to each this state
  
end
% print path and node value
% the last entry is the optima cost
% to identify the optimal path you will have to backtrack

fprintf('\nOptimal path values at various nodes - Values(i)\n'), disp(pathvalue)
fprintf('\nBest previous node to reach current node -Node(i)\n'), disp(nodevalue)

% backtrack additonal paths yielding same optimal value
% addnode contains information n additional nodes
% Note: this is not the most eficient or informative 
% way to keep track of information - but is the easiest
fprintf('\nAdditional nodes for same optimal value if any \n'), disp(addnode)