% 	
% Ch 5: Numerical Techniques - 1 D optimization
% Optimzation with MATLAB, Section 5.2.4
% Generic Polynomial Approximation Method - Single Variable
% copyright Dr. P.Venkataraman
%	
% An m-file to apply the Polynomial Approximation Method
%************************************
% requires:     UpperBound_1Var.m
%***************************************
%
% the following information are passed to the function

% the name of the function 			'functname'
% this function should be available as a function m-file
% and shoukd return the value of the function
%
% the order										2 or 3

% following needed for UpperBound_1Var
% the initial value							lowbound
% the incremental value 					intvlstep
% the number of scanning steps	    	ntrials
%
%  the function returns a row vector of the minimum point on the polynomial 
% and the value of the function at the point
%	sample callng statement

%  PolyApprox_1Var('Example5_1',2,0,1,10)
% this should give you a value of [1.5  -0.75] as in
% the text and the plot


function ReturnValue = ...
   PolyApprox_1Var(functname,order,lowbound,intvlstep,ntrials)

format compact
lowval =lowbound;
up = UpperBound_1Var(functname,lowbound,intvlstep,ntrials);
upval=up(1);

switch order
   case 2
      val1 = lowval + (upval -lowval)*.5;
      f1 = feval(functname,lowval);
      f2 = feval(functname,val1);
      f3 = feval(functname,upval);
   
      A = [1 lowval	lowval^2 ; 1 val1 val1*val1 ; 1 upval upval^2]
      coeff =inv(A)*[f1 f2 f3]';
      polyopt = -coeff(2)/(2*coeff(3));
      fpoly = coeff(1) + coeff(2)*polyopt +coeff(3)*polyopt*polyopt;
      ReturnValue = [polyopt fpoly];
   otherwise
      val1 = lowval + (upval -lowval)*.33;
      val2 = lowval + (upval -lowval)*.66;
      
      f1 = feval(functname,lowval);
      f2 = feval(functname,val1);
      f3 = feval(functname,val2);
      f4 = feval(functname,upval);
  
      A = [1 lowval	lowval^2 lowval^3; ...
         1 val1 val1*val1 val1^3; ...
         1 val2 val2*val2 val2^3; ...
         1 upval upval^2 upval^3];
      coeff =inv(A)*[f1 f2 f3 f4]';
      
      disc = (4*coeff(3)^2 - 12*coeff(2)*coeff(4));
      if  disc > 0
         p1  = (-2*coeff(3) + sqrt(disc))/(6*coeff(4));
         p2  = (-2*coeff(3) - sqrt(disc))/(6*coeff(4));
         fp1 = feval(functname,p1);
         fp2 = feval(functname,p2);
      
         if (fp1 >= fp2)  ReturnValue = [p2, fp2];
         else ReturnValue = [p1, fp1];
         end
      else
         fprintf(']n 3 order - imaginary roots - no acceptable solution')
      end  
end
