function ret = ArithmeticCrossover(nDes,nP,nAC,X)
%
%	creating children by simple crossover
%  nSc = 1 (only)
%
global xv1 yv1 xv2 yv2
XP1 = X(1,:);
XP2 = X(2,:);


r1 = rand(1,1);
r2 = 1 - r1;

for i = 2:2:nDes
	XC1(i) = r1*XP1(i) + r2*XP2(i);
	XC2(i) = r2*XP1(i) + r1*XP2(i);
end
for i = 1:2:nDes-1
   XC11 = r1*XP1(i) + r2*XP2(i);
   if XC11 < xv2
      XC1(i) = XP1(i) ;
   end
   XC22 = r2*XP1(i) + r1*XP2(i);
   if XC22 < xv2
      XC2(i) = XP2(i) ;
   end
   
end
for i = 1:2:nDes - 3
   dx = XC1(i+2)-XC1(i);
   if abs(dx) > 0.05
      a=1;
   else
      XC1(i+2) = XC1(i) + 0.1;
   end
end
for i = 1:2:nDes - 3
   dx = XC2(i+2)-XC2(i);
   if abs(dx) > 0.05
      a=1;
   else
      XC2(i+2) = XC2(i) + 0.1;
   end
end


%[XP1' XP2']
%[XC1' XC2']
ret =[XC1; XC2];