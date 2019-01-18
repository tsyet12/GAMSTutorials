% drawing bezier curves

nBez = 3;  % order of curve
XYVert = [0 0.75 1.5 2; 0 0.75 0.25 1]';
nTotal = 50;  % number of points on curve
DX = 1/(nTotal - 1);

A = coeff(nBez);
for i = 1:nTotal
      gam = (i - 1)*DX;
      for j = 1:nBez+ 1
         k = nBez+1 - j;
         GAM(j) = gam^k;
      end
      %XYVert=[VX;VY]';
      Xfit = GAM*A*XYVert;
      XF(i) = Xfit(1);
      YF(i) = Xfit(2);
      
   end
   plot(XF,YF,'r-',XYVert(:,1),XYVert(:,2),'b--')
   title('Cubic Bezier curves')
   xlabel('x - data ')
   ylabel('y - data ')
   grid
   
   

