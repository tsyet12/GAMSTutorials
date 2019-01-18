
XYVert = [XV' YV'];
DX = 1/(ntotal - 1);
for i = 1:ntotal
   gam = (i - 1)*DX;
   for j = 1:nBez+ 1
      k = nBez+1 - j;
      GAM(j) = gam^k;
   end
   Xfit = GAM*A*XYVert;
   XF(i) = Xfit(1);
   YF(i) = Xfit(2);
end

plot(XX,YY,'k-',XF,YF,'r--',XYVert(:,1),XYVert(:,2),'bo')
title('Cubic Bezier curves')
xlabel('x - data ')
ylabel('y - data ')
grid


 
