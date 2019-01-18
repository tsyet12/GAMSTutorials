function ret = SimpleCrossover(nDes,nP,nSC,X)
%
%	creating children by simple crossover
%  nSc = 1 (only)
%
XP1 = X(1,:);
XP2 = X(2,:);


r = rand(1,1);
if r > 0.5
   r1 = floor(nDes*r);
else
   r1 = ceil(nDes*r);
end
for i = 1:1:length(XP1)
   if i < r1
      XC1(i) = XP1(i);
      XC2(i) = XP2(i);
   else
      XC1(i)= XP2(i);
      XC2(i)= XP1(i);
   end
end

%for i = 1:2:nDes-1
 %  XC1(i) = XP1(i) ;
 %  XC2(i) = XP2(i) ;
%end

%[XP1' XP2']
%[XC1' XC2']
ret =[XC1; XC2];