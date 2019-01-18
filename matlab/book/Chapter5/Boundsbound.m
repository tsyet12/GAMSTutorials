% An m-file to bracket the minimum of a function
% Since this procedure will be used to along with the golden section method
%
% the name of the function 			'funname'
% the current position vector 			x
% the current search direction vector	s
% the initial step							a0
% the incremental step						da
% the number of bracketting steps		ns
%
%	are passed along with the call
function valueB = Boundsmin(functname,x,s,a0,da,ns)

ok = 1; 	ntrials = 10;	% ok is used for immediate exit
%	ntrials are used execute bisected or double values of da



das = da;	nss = ns; % prevent overwriting da and ns
count = 1;
   for i = 1:ntrials;
     
      j = 0;	dela = j*das;	a00 = a0 + dela;  
      dx0 = a00*s;	x0 = x + dx0;  f0 = feval(functname,x0);
      j = j+1;	dela = j*das;	a01 = a0 + dela;
      dx1 = a01*s;	x1 = x + dx1;	f1 = feval(functname,x1);
      %str1 = 'outer for loop'
      %[f0 f1]
      if f1 < f0 
         for j = 2:nss
         	a01 = a0 + j*das;		dx1 = a01*s;	
            x1 = x + dx1;		f1 = feval(functname,x1);
            %str2 = 'inner for loop'
            %[f0 f1]
            if f1 >= f0 
      			valueB = [a01 f1 x1];
               return;
            end
         end
      	valueB = [a01 f1 x1];
         return;
			         
      else	f1 >= f0;
         %str3 = 'else loop'
         %count = count + 1;
         %[f0 f1]
         das = 0.5*das;
         %if count == 3
          %	valueB = [a01 f1 x1];
          	%return;
       %end
   	end
	end
	valueB =[a0 f0 x0];