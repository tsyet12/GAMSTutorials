%	Construct the Bezier Least Square Curve
%	First the parameter has to be deteremined
%	Using a Newton-Raphson Technique. Then the 
% 	corresponding relation is estimated
function returnvalue = Bez_Sq_Err(x)
global nBez A XX YY WT
global xv1 yv1 xv2 yv2

nd = length(XX);
errsum = 0.0;
nDes = 2*(nBez+1) - 4;
xdum(1) = xv1;
ydum(1) = yv1;
j=2;
for i = 2:2:nDes
   xdum(j) = x(i-1);
   ydum(j) = x(i);
   j=j+1;
end
xdum(nBez + 1) = xv2;
ydum(nBez + 1) = yv2;
%disp(xdum)
for i = 1:nd
   xe = XX(i);
   for j = 1:nBez+1
      b(j) = 0.0;
      for k = 1:nBez + 1
         b(j) = b(j) + A(j,k)*xdum(k);
      end
   end
   
   b(nBez+1) = b(nBez+ 1) -xe;
   
   xi = (xe - xv1)/(xv2 - xv1);
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
   errsum = errsum + (YY(i) - phi)*(YY(i) - phi);
end
returnvalue = errsum;
   