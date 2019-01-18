% 	
% Ch 6: Numerical Techniques for Unconstrained Optimization
% Optimzation with MATLAB, Section 6.2.1
% Random Walk Method 
% copyright (code) Dr. P.Venkataraman
%	
% An m-file for the Random Walk Method
%************************************
% requires:     	UpperBound_nVar.m
%						GoldSection_nVar.m
%	and the problem m-file: Example6_1.m
%***************************************
%
% the following information are passed to the function

% the name of the function 			'functname'
% this function should be available as a function m-file
% and should return the value of the function 
% corresponding to a design vector 
%
%	initial design vector					dvar0
%  number of iterations                niter

%------for golden section
%  the tolerance (for golden section)	tol 
%
%-------for upper bound calculation
% the initial value of stepsize			lowbound
% the incremental value 					intvl
% the number of scanning steps	    	ntrials
%
% the function returns the final design and the objective function

%	sample callng statement

% RandomWalk('Example6_1',[0.5 0.5],10, 0.001, 0,1 ,10)
%
function ReturnValue = ...
   RandomWalk(functname,dvar0,niter,tol,lowbound,intvl,ntrials)
format compact;
clf % clear figure
nvar = length(dvar0); % length of design vector or number of variables
% obtained from start vector 
if (nvar == 2)
%*************************
%  plotting contours - please comment for more than two vatiables
%*************************

% for 2 var problems the contour plot can be drawn
x1 = -2:0.1:5;
x2 = -2:0.1:5;
x1len = length(x1);
x2len = length(x2);
for i = 1:x1len;
   for j = 1:x2len;
      x1x2 =[x1(i) x2(j)];
      fun(j,i) = feval(functname,x1x2);
   end
end
c1 = contour(x1,x2,fun, ...
  [ 3 5 10 25 50 100],'k');

% c1 = contour(x1,x2,fun, ...
 %  [3.1 3.25 3.5 4 6 10 15 20 25],'k'); %contour values for Ex 6.1
%clabel(c1); % remove labelling to mark iteration
grid
xlabel('x_1')
ylabel('x_2')
title('Example - passed in call')
%**************
% finished plotting contour
%**************

% note that contour values are problem dependent
% the range is problem dependent
end

hstep = 0.001; % step for finite difference slope calculation
% find search direction

% design vector, search vector.alpha , and function value is stored
xs(1,:) = dvar0;
x = dvar0;
fs(1) = feval(functname,x); % value of function at start
as(1)=0;
for i = 1:niter-1
   % determine search direction
   s = rand(nvar,1)';  % remember these elements in the positive quadrant
   sign = rand(nvar,1)'; % used to change signs for s
   
   for j = 1:nvar
      if (sign(j)> 0.5) s(j) = -s(j); end  
   end
   % the search direction is available in s
   % store this value
   ss(i,:) = s;
   
   % check for intial positive slope
   % if slope is positive then go to the next iteration
   % this step causes function to increase ( alpha = 0)
   % 
   curx = x;
   
   nextx = curx + hstep*s;
   slope = (feval(functname,x+hstep*s)-feval(functname,x)) ...
      /hstep;
   
   % if slope > 0, then exit this iteraion.
   if(slope < 0) 
      output = GoldSection_nVar(functname,tol,x, ...
         s,lowbound,intvl,ntrials);
      as(i+1) = output(1);
      fs(i+1) = output(2);
      for k = 1:nvar
         xs(i+1,k)=output(2+k);
         x(k)=output(2+k);
      end
      %**********
      % draw lines
      %************
      if (nvar == 2)
      line([xs(i,1) xs(i+1,1)],[xs(i,2) xs(i+1,2)],'LineWidth',2,'Color','r')
      itr = int2str(i);
      x1loc = 0.5*(xs(i,1)+xs(i+1,1));
      x2loc = 0.5*(xs(i,2)+xs(i+1,2));
      % iteration number not printed for Example 6.2
      %text(x1loc,x2loc,itr); % writes iteration number on the line
      end
      %*********
      % finished drawing lines
      %************
      pause(1)
   else
      as(i+1) = 0;
      fs(i+1) = fs(i);
      xs(i+1,:)=xs(i,:);
   end
   disp([i xs(i,:) fs(i)]);
end
len=length(as);
for kk = 1:nvar
   designvar(kk)=xs(len,kk);
end
fprintf('The problem:  '),disp(functname)
%fprintf('\n - The design vector and function during the iterations')
%[xs fs']
%ReturnValue = [designvar fs(len)]; pre-Sec. 6.5 - return number of iteration
ReturnValue = [len designvar fs(len)];
