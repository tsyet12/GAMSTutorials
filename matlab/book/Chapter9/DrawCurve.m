function DrawCurve(Vect,ig)
global nBez A XX YY 
global xv1 yv1 xv2 yv2


XV(1)= xv1;
XV(nBez+1)=xv2;   
YV(1)=yv1;
YV(nBez+1)=yv2;
   
clf;
j=1;
for i = 2:nBez  
  XV(i)= Vect(j);
  YV(i)= Vect(j+1);
  j= j+2;
end

ntotal = length(XX);
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
genval = int2str(ig);
gennumber = strcat('Gen:',genval);
plot(XX,YY,'k-',XF,YF,'r--',XV,YV,'bo')
title('Bezier curves')
legend('Original Data',gennumber,'vertices')
xlabel('x - data ')
ylabel('y - data ')
grid

