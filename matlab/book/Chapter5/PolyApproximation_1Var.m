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

% This procedure will be used along with
% Polynomial Approximation or with the Golden Section Method
%
% the following information are passed to the function
% the name of the function 			'functname'
% the function should be available as a function m.file
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


function ReturnValue = ...
   PolyApproximation_1Var(functname,order,lowbound,intvlstep,ntrials)

format compact
lowval = 0.0
up = UpperBound_1Var(functname,lowbound,intvlstep,ntrials)
upval=up(1)

if (order == 2)
   val1 = lowval + (upval -lowval)*.5
   f1 = feval(functname,lowval)
   f2 = feval(functname,val1)
   f3 = feval(functname,upval)
   
   A = [1 lowval	lowval^2 ; 1 val1 val1*val1 ; 1 upval upval^2];
   coeff =inv(A)*[f1 f2 f3]';
   polyopt = -coeff(2)/(2*coeff(3))
   fpoly = coeff(1) + coeff(2)*polyopt +coeff(3)*polyopt*polyopt
   ReturnValue = [polyopt fpoly];
end
