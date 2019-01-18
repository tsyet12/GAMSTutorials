% fuction for drawing the state of the generation
% for Example 9.3
% input the design vector
% CallGA must be run to activate the global statement

function drawcur(Vect)
global nBez A XX YY 

% this information is transfered from CallGA
%for i = 1:100
%	XX(i)=i*0.02;
%   YY(i)=1 +0.25*XX(i) + 2*cos(3*XX(i))*exp(-XX(i));
%end
%nBez= 5;
%A = coeff(nBez);
%clf

ntotal = length(XX);
XV(1)= XX(1);
XV(nBez+1)=XX(ntotal);   
YV(1)=YY(1);
YV(nBez+1)=YY(ntotal);

% create the x-y vertices
j=1;
for i = 2:nBez  
  XV(i)= Vect(j);
  YV(i)= Vect(j+1);
  j= j+2;
end

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

plot(XX,YY,'k-',XF,YF,'r--',XV,YV,'bo')
title('Example 9.3')
legend('Original Data','Fitted data','Vertices')
xlabel('x - data ')
ylabel('y - data ')
grid

