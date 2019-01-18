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
delx=[1 .1 .01 .001];  % decreasing displacements - vector
xvar =xp + delx;	%  neighboring points - vector		

fvar =subs(f,xvar);%  function values at neighboring points
fp =subs(f,xp);		%	function value at xp
dfp=subs(deriv,xp); % actual value of derivative at xp

delf = fvar-fp;	%  change in the function values
derv= delf./delx ; %  derivative using definition
%  limiting process is being invoked
%	as displacement is getting smaller
ezplot(f,[0,4])  % symbolic plot of the original function
%						 between 0 and 4

% draw a line at value of 12 for reference
line([0 4],[12 12],'Color','g','LineWidth',1)

figure		% use a new figure for animation
%				  figures are drawn as if zooming in

for i = 1:length(delx)
   clf		% clear reference figure
   ezplot(f,[xp,xvar(i)])
   %  plot function within the displacement value only
   line([xp xvar(i)],[fp subs(f,xvar(i))],'Color','r')
   pause(2)  % pause for 2 seconds - animation effect
end

xpstack=[xp xp xp xp]; % dummy vector for display
dfpstack=[dfp dfp dfp dfp];  % same

[xpstack' delx' xvar' delf' derv' dfpstack']

% this information is availabl in Table 4.1