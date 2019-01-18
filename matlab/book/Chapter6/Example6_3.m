% 	
% Ch 5: Numerical Techniques - 1 D optimization
% Optimzation with MATLAB, Section 5.4.2
% TPBVP - Blassius Problem - Flow over a flat plate
% Example of a real 1 variable optimization problem
% copyright (code) Dr. P.Venkataraman
%	
% 
%************************************
% requires:    UpperBound_1Var.m
%					GoldSection_1Var.m
%					state.m
%***************************************
%
% uses Matlab ODE45 - Runge-Kutta method
%
function ReturnVal = Example6_3(x)

ti = 0.0; % start of integration
tf = 5.0; % final value of integration - ideally infinity
% previous solution suggest this is a good choice
% can also be a design variable - in that case it 
% will be a two-variable problem

tintval = [ti x(3)];  % array of start and finish points

bcinit = [0 x(1) 1 x(2) 0]; % initial values for the integration
%  note x is the design variable

[t y ] = ode45('Ex6_3_state',tintval,bcinit);

% in the above, the ode45 will look for a file called
% state.m   where the system equations are to be found
% the system equations must be formulated in state space form

n = length(t); % to establish the final values
% ode45 in this usage is a variable  step integrator

% return the error in the final value of the first derivative
% this was the boundary condition at the final point
ReturnVal = y(n,1)*y(n,1) + y(n,3)*y(n,3);

% The following can be printed if you are curious
%[t y];

%plot(t,y(:,2),'k-') % only interested in velocity profile
%grid
%title('Laminar flow over a flat plate')
%xlabel('u/U_(inf)')
%ylabel('non-dimensional y')