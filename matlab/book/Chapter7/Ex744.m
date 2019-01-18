% Optimization with MATLAB
% Dr. P.Venkataraman
% Published by John Wiley
%
% Chapter 7, Section 7.3.3
% Example 7.4
% Optimal Control - Find feasible trajectory
% Uses unconstrained minimizer from Optimization Toolbox
%  - fminunc
% See text for problem description
%
%-----------------------------------
% Bezier curve definition requires: coeff.m
%												Combination.m
%												Factorial.m
% Bezier curve is also handled in brachi.m which provides
% the derivatives in state space definition
%------------------------------------------------
% Example needs obj_optcont.m
% This provides the objective function for the minimizer
% uses ode45.m from MATLAB

global xx1 xx2 yy1 yy2 nBez A v0
global xv1 xv2
global phi nDes
global xdes

format compact
clc

% nBez : order of the Bezier Curve
nBez= 4;

% A : contains the coefficients of the curve 
% this is a one time calculation
% it is  done here as preprocessing
A = coeff(nBez);

% define initial and final positions in 2D space
% xx2 and yy2 provide the target
xx1 = 0; xx2 = 3; yy1 = 0; yy2 = 2;

v0 = 5;  % velocity magnitude

% set up the design vector for control to be described
% by a Bezier curve
% i.e. the x-y vertices of the Bezier curve for theta
% x is the time , y is the theta for the control
% (sorry for the confusion in using x-y again)
% 
nv = 2*(nBez + 1);  % number of elements in vector

% set up vertices for plotting
XV(1) = 0;
xv1 = XV(1);
XV(nBez+1)= 1;
xv2 = XV(nBez+1);
YV(1)=0;
yv1 = YV(1);
YV(nBez+1)=1.5;
yv2 = YV(nBez+1);
  
for i = 2:nBez   % linearly define initial vertices
   j=i-1;
   XV(i) = XV(1)+j*((xv2-xv1)/nBez);
   YV(i) = YV(1)+j*((yv2-yv1)/nBez);   
end
j=1;
for i = 1:2:2*nBez+1	% assemble the initial design vecor
   x(i) = XV(j);   
   x(i+1)=YV(j);
   j=j+1;
end
x(1) = xv1;  % the the first and last time 
% values are fixed. By oversight they 
% were allowed to vary. This forces them to stay fixed
% at initial point
x(nv-1) = xv2;

plot(XV,YV,'ro')  % plot initial vertices
hold on

xorig = x    % print original vector to screen and store

% call the optimizer
% set maximum iterations
options = optimset('MaxIter',10);
xst = fminunc('obj_optcont',x,options)

j=1;
for i = 1:2:2*nBez+1  % populate vertices for plotting
   XV(j) = xst(i);   
   YV(j) = xst(i+1);
   j=j+1;
end

nD1 = 50;				% draw curve for 50 data points
DX = 1/nD1;
for i = 1:nD1
   gam = (i - 1)*DX;
   for j = 1:nBez+ 1
      k = nBez+1 - j;
      GAM(j) = gam^k;
   end
   XYVert=[XV;YV]';
   Xfit = GAM*A*XYVert;
   XF(i) = Xfit(1);
   YF(i) = Xfit(2);   
end

plot(XF,YF,'b--',XV,YV,'ko');
title('The vertices and \theta (t)')
xlabel('time')
ylabel('\theta (t)')
legend('start vertices','theta','final vertices')

hold off

figure	% use an additional figure to draw 
% initial and final trajectory


xdes = xst
nDes = 2*(nBez+1);

% obtain the trajectory for the final design
tinterval = [0 1];
h0 = [xx1 yy1];
[t h] = ode45('brachi',tinterval,h0); 

plot(h(:,1),h(:,2),'r-')  % y versus x

grid
hold on		

% plot the starting trajectory
xdes = xorig;
tinterval = [0 1];
h0 = [xx1 yy1];
[t h] = ode45('brachi',tinterval,h0); 

plot(h(:,1),h(:,2),'k--')
legend('final trajectory','initial trajectory')
plot(xx1,yy1,'m*',xx2,yy2,'c*')  % define target on figure
title('Feasible trajectory')
xlabel('x')
ylabel('y')

grid

  