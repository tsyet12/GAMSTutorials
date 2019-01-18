% 	
% Ch 5: Numerical Techniques - 1 D optimization
% Optimzation with MATLAB, Section 5.2.4
% Generic Scanning Procedure - Single Variable
% copyright Dr. P.Venkataraman
%	
% An m-file to bracket the minimum  
%	of a function of a single 
% Lower bound is known 
% only upper bound is found

% This procedure will be used along with
% Polynomial Approximation or with the Golden Section Method
%
% the following information are passed to the function
% the name of the function 			'functname'
% the function should be available as a function m-file
% and shoukd return the value of the function
%
% the inputs
% the initial value							a0
% the incremental value 					da
% the number of scanning steps	    	ns
%
%	sample callng statement

%  UpperBound_1Var('Example5_1',0,1,10)
% this should give you a value of [4 18] as in
% the text


function ReturnValue = UpperBound_1Var(functname,a0,da,ns)

format compact
%	ntrials are used to bisect/double values of da
if (ns ~= 0) ntrials = ns;
else ntrials = 20;   % default
end

if (da ~= 0) das = da;
else das = 1;  %default
end
% modification for a positive slope
% check if initial slope is positive
fstart = feval(functname,a0);
fnext = feval(functname,(a0 + 0.1*das));
slope =(fnext-fstart)/(0.1*das);
if (slope > 0)
   for i = 2:ntrials
      astart = a0 + i*das;
      anext = astart + 0.1*das;
      fstart = feval(functname,astart);
      fnext = feval(functname,anext);
      newslope = (fnext - fstart)/(anext - astart);
      if (newslope < 0)
         a0= astart;
         break;
      end
   end   

end
for i = 1:ntrials;
   j = 0;	dela = j*das;	a00 = a0 + dela;
   f0 = feval(functname,a00);
   
   j = 1;	dela = j*das;	a01 = a0 + dela;
   f1 = feval(functname,a01);      
   f1s =f1;
   if f1 < f0 
      for j = 2:ntrials
            aa01 = a0 + j*das;	
            af1 = feval(functname,aa01);
            f1s=min(f1s,af1);
         if af1 > f1s 
      		ReturnValue = [aa01 af1];
            return;
          end
      end
         % after ntrials the value is still less than start 
         %return last value
      fprintf('\n cannot increase function value\n')
      ReturnValue = [aa01 af1];
      return;
			         
   else	
       
       das = 0.5*das;
      
         
   end
end
fprintf('\ncannot decrease function value \n')
if (slope > 0)
   fprintf('\ninitial slope is greater than zero'),disp(slope)
   fprintf('\nlower bound needs adjusting \n')
end
% return start value
ReturnValue =[a0 f0];