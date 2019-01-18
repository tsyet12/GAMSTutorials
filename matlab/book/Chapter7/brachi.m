% fuction handles the definition of state space vector
% returns the value of the first derivative 
function ret = brachi(t,y)
global xx1 xx2 yy1 yy2 nBez A v0
global phi nDes
global xdes
global xv1 xv2


% need to obtain the value of the control theta(t)
% picks up the design variables
j=1;
for i = 2:2:nDes
   xdum(j) = xdes(i-1);
   ydum(j) = xdes(i);
   j=j+1;
end
xdum(1) = 0;
xdum(nBez+1) = 1;
%ydum;

% tries to identify the parameter between 0 and 1
% using a Newton-Raphson procedure
xe = t;
for j = 1:nBez+1
   b(j) = 0.0;
   for k = 1:nBez + 1
      b(j) = b(j) + A(j,k)*xdum(k);
   end
end
   
b(nBez+1) = b(nBez+ 1) -xe;
xvv1 = xdum(1); xvv2 = xdum(nBez + 1);  
xi = (xe - xvv1)/(xvv2 - xvv1);
   %xi
   %b
delx = 100.0;
ii=1;
while ( abs(delx) > 1.0e-08) 
  if(ii == 10)  % to prevent stalling of the computation
      % in this case whatever is the current value is returned
      break
  end
      
  phi = 0.0;
  phix = 0.0;
  for j = 1:nBez + 1
      k = nBez+ 1 -j;
      phi = phi + b(j)*xi^k;
   end
   for j = 1:nBez
      k = nBez+1 -j;
      l = k - 1;
      phix = phix + k*b(j)*xi^l;
   end
      %phi
      %phix
   delx = -phi/phix;
   xi = xi + delx; 
   ii=ii+1;
end
% use this xi to obtain yi - the bezier interpolated value
for j = 1:nBez+1
   b(j) = 0.0;
   for k = 1:nBez + 1
      b(j) = b(j) + A(j,k)*ydum(k);
   end
end

   phi = 0.0;
   
for j = 1:nBez + 1
   k = nBez+ 1 -j;
   phi = phi + b(j)*xi^k;
end

% phi is the value of theta at this value of t


ret =[v0*cos(phi), v0*sin(phi)]';

