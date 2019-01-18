% 	
% Ch 5: Numerical Techniques - 1 D optimization
% Optimzation with MATLAB, Section 5.2.5
% Generic Golden Section Method - Single Variable
% copyright (code) Dr. P.Venkataraman
%	
% An m-file to apply the Golden Section Method
%************************************
% requires:     UpperBound_1Var.m
%***************************************
%
% the following information are passed to the function

% the name of the function 			'functname'
% this function should be available as a function m-file
% and shoukd return the value of the function
%
% the tolerance										0.001

% following needed for UpperBound_1Var
% the initial value							lowbound
% the incremental value 					intvl
% the number of scanning steps	    	ntrials
%
%  the function returns a row vector of 
% four sets of varaiable and function values 
% for the last iteration %	sample callng statement

% GoldSection_1Var('Example5_1',0.001,0,1,10)
%
function ReturnValue = ...
   GoldSection_1Var(functname,tol,lowbound,intvl,ntrials)
format compact;

% gets upperbound

upval = UpperBound_m1Var(functname,lowbound,intvl,ntrials);

au=upval(1);	fau = upval(2);

if (tol == 0) tol = 0.0001; %default
end

eps1 = tol/(au - lowbound); %default
tau = 0.38197; % golden ratio
nmax = round(-2.078*log(eps1));  % number of iterations

aL = lowbound;	faL =feval(functname,aL);;	
a1 = (1-tau)*aL + tau*au; fa1 = feval(functname,a1);
a2 = tau*aL + (1 - tau)*au; fa2 = feval(functname,a2);

% storing all the four values for printing 
fprintf('start  \n')
fprintf('alphal(low)   alpha(1)   alpha(2)  alpha{up) \n')
avec = [aL a1 a2 au;faL fa1 fa2 fau];
disp([avec])
for i = 1:nmax

	if fa1 >= fa2
   	aL = a1;	faL = fa1;
   	a1 = a2;	fa1 = fa2;
   	a2 = tau*aL + (1 - tau)*au;	fa2 = feval(functname,a2);
   	au = au;	fau = fau;  % not necessary -just for clarity
      
      
      fprintf('\niteration '),disp(i)
      fprintf('alphal(low)   alpha(1)   alpha(2)  alpha{up) \n')
      avec = [aL a1 a2 au;faL fa1 fa2 fau];
		disp([avec])

	else
  	   au = a2;	fau = fa2;
   	a2 = a1;	fa2 = fa1;
   	a1 = (1-tau)*aL + tau*au;	fa1 = feval(functname,a1);
   	aL = aL;	faL = faL;  % not necessary
      
      fprintf('\niteration '),disp(i)
      fprintf('alphal(low)   alpha(1)   alpha(2)  alpha{up) \n')
      avec = [aL a1 a2 au;faL fa1 fa2 fau];
		disp([avec])

	end
end
% returns the value at the last iteration
ReturnValue =[aL faL a1 fa1 a2 fa2 au fau];



