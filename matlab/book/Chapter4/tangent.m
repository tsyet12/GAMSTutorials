% Illustration of the derivative
%  Optimization Using MATLAB
%	Dr. P.Venkataraman
%
%	section 4.2.2
%	This example illustrates the limiting process
%	in the definition of the derivative
%	In the figure animation 
%	1. 	note the scales
%	2.  	as the displacement gets smaller the function
%			and the straight line coincide suggesting the 
%			the line is tangent t the curve at the point
%
	
syms x f deriv		% symboli variables
f=12+(x-1)*(x-1)*(x-2)*(x-3); % definition of f(x)
deriv=diff(f);		% computing the derivative

xp = 3.0;			% point at which the 
                  % derivative will be computed
fp =subs(f,xp);		%	function value at xp
dfp=subs(deriv,xp); % actual value of derivative at xp
ezplot(f,[0,4])  % symbolic plot of the original function
%						 between 0 and 4

% draw a line at value of 12 for reference
line([0 4],[12 12],'Color','g','LineWidth',1)
line([2.5 3.5],[10,14],'Color','k', ...
   'LineStyle','--','LineWidth',2)
axis([0 4 8 24])
title('tangent - slope - derivative at x=3') 
text(.6,21,'f=12+(x-1)*(x-1)*(x-2)*(x-3)')
ylabel('f(x)')
text(3.2,12.5,'\theta')
text(2.7,10.5,'tangent')
grid
