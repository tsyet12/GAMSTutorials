% Optimization Using MATLAB, Chapter 9
% Dr. P.Venkataraman
% Chapter: 9, Section 9.2
% Simulated Annealing
%************************************************
% requires:     	UpperBound_nVar.m
%						GoldSection_nVar.m
%	and the problem m-file: Example9_1.m
%  the problem file for plotting Example9_1plot.m
%*************************************************
%
% the following information are passed to the function
%
% the name of the function 			'functname'
% this function should be available as a function m-file
% and should return the value of the function 
% corresponding to a design vector 
%
%	initial design vector					dvar0
%  number of iterations                niter
%
%------for golden section
%  the tolerance (for golden section)	tol 
%
%-------for upper bound calculation
% the initial value of stepsize			lowbound
% the incremental value 					intvl
% the number of scanning steps	    	ntrials
%
% the function returns the final design and the objective function
%
%	sample callng statement
%
% SimulatedAnnealing('Example9_1',[-5 -5],10, 0.001, 0,1 ,10)
%
function ReturnValue = ...
   SimulatedAnnealing(functname,dvar0,niter,tol,lowbound,intvl,ntrials)
%----------------------------------------------------------------------
% length of design vector or number of variables
% obtained from start vector 
nvar = length(dvar0); 
astore = 1; % store the most recent value of alpha used
bstore = 1;   % initailization
if (nvar == 2)
%********************************************
%  plotting contours - for two variables only
%  this section is problem dependent
%*********************************************
%
	x1 = -5:0.1:5;
	x2 = -5:0.1:5;

	[X1, X2] = meshgrid(x1,x2);

	set(gcf,'Name','Contour for Example 9.2')
	f = Example9_2plot(X1,X2);
	[c, h] = contourf(x1,x2,f,[-7,-6,-5,-4,-3,-2,-1,-0.5,0,0.5,1,2,3,4,5]);
	clabel(c,h)
	% contour labels crowd the figure - use color to understand
	colormap(bone);
   colorbar;
  
	title('Contours and Moves - SA - Example 9.2')
	xlabel('x_1 - values')
	ylabel('x_2 - values')
   max(max(f))
   min(min(f))
   
%***************************
% finished plotting contour
%**************************
end
is = 1;
iter(is) = 1;
hstep = 0.001; % step for finite difference slope calculation


% design vector, search vector,alpha, and function value is stored
xs(is,:) = dvar0;
x = dvar0;
fs(is) = feval(functname,x) % value of function at start
as(is)=0;
 for k = 1:nvar
    ss(is,k)=0;
 end
%******************************************
%  Set up control parameters for simulated annealing
delf0 = 0.5*fs(1);  % delta f is 50 % of initial value
p0 = 0.7;
beta0 = -log(p0)/delf0
if abs(beta0) < 1
   beta0 = 1;
end
if abs(beta0) > 2.5 % change made in Example 9.2
   beta0 = 2.5;
end

if beta0 > 0 
   beta0 = -1*beta0
end
%*******************************************
% iteration starts here
for i = 1:niter-1
   % determine search direction
   s = rand(nvar,1)';  % remember these elements
   						  % are in the positive quadrant
   sign = rand(nvar,1)'; % used to randomly change signs for s
   
   for j = 1:nvar
      if (sign(j)> 0.5) s(j) = -s(j); end  
   end
   % check for positive slope
   % if slope is positive then determine if solution is
   % allowed to escape
   %
   nextx = x + hstep*s;
   slope = (feval(functname,nextx)-feval(functname,x)) ...
      /hstep;
   
   % if slope > 0, then exit this iteraion.
   if(slope < 0) 
      output = GoldSection_nVar(functname,tol,x, ...
         s,lowbound,intvl,ntrials);
      as(is+1) = output(1);
      bstore = output(1);
      fs(is+1) = output(2);
      ss(is+1,:) = s;
      for k = 1:nvar
         xs(is+1,k)=output(2+k);
         x(k)=output(2+k);
      end
            %**********
      % draw lines
      %************
      if (nvar == 2)
        line([xs(is,1) xs(is+1,1)],[xs(is,2) xs(is+1,2)], ...
           'LineWidth',1,'Color','r')
        
           is = is + 1;
           iter(is)=i;
           textitr(is)= {'dec'};
		%fprintf('descending loop\n')
     end
      %*********
      % finished drawing lines
      %************
      
   elseif (slope >= 0)
      astore = max(bstore,1);  % if the alpha at the 
      % previous goldensection calculation is too low
      nextx = x + astore*s;
      delf = (feval(functname,nextx)-feval(functname,x));
      pnew = exp(beta0*delf);% negative sign dropped 
      %        because the way delf is defined above
      rpnew = rand(1,1);   % random number for escape decision
      if (rpnew <= pnew)   % let it escape
         x = nextx;
         as(is+1) = 0;
      	fs(is+1) = feval(functname,x);
      	ss(is+1,:) = s;
      	for k = 1:nvar
            xs(is+1,k)=x(k);
      	end
         
          % draw lines
      	%************
      	if (nvar == 2)
        		line([xs(is,1) xs(is+1,1)],[xs(is,2) xs(is+1,2)], ...
           'LineWidth',1,'Color','b')
        

      	end
         is = is + 1;
         iter(is)=i;
         textitr(is)={'inc'}; 
         %fprintf('function increase allowed\n')
   	end
   end
end
len=length(as);   % number of iterations when design changed
for kk = 1:nvar
   designvar(kk)=xs(len,kk);
end
%fprintf('\nThe problem:  '),disp(functname)
%fprintf('\n - The design vector and function during the iterations')
%[xs fs' iter']  % print values of design cjanges
%textitr         % print info of which loop was executed for design changes
ReturnValue = [niter len designvar fs(len)];