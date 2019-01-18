function ret = DirectionalCrossover(nDes,nP,nDC,X,fX)
%
%	creating children by simple crossover
%  nSc = 1 (only)
%
global xv1 yv1 xv2 yv2
XP1 = X(1,:);
XP2 = X(2,:);
f1 = fX(1);
f2 = fX(2);

r1 = rand(1,1);
for i = 2:2:nDes
	if f1 < f2
   	XC(i) =  XP1(i) + r1*(XP1(i)- XP2(i));
	else
   	XC(i) = XP2(i) + r1*(XP2(i) - XP1(i));
	end
end
%for i = 1:2:nDes-1
 %  if f1 < f2
  %%   if XXC < xv2
    %     XC(i)=XXC;
     % else
      %   
       %  XC(i) =  XP1(i);
    %  end
      
%	else
%		XXC =  XP2(i) + r1*(XP2(i) - XP1(i));
 %     if XXC < xv2
  %       XC(i)=XXC;
  %    else
         
   %      XC(i) = XP2(i);
      %end

   
	%end
%end

%[XP1' XP2']
%[XC1' XC2']
ret = XC;