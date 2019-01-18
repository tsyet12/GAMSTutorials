function ret = Mutation(nDes,X)
global xv1 yv1 xv2 yv2
% mutate all the vectors by changing a single element
XX = X;
[n m] =size(X);

xcur = xv1;
frac = 0.3;
    
dxv = xv2 - xv1;
dyv = 4;
for i = 1:2:nDes-1
   x(i) = xcur + (xv2 - xcur)*frac*rand(1,1);
   x(i+1) =  dyv*rand(1,1);
   xcur = x(i);
   frac = 1;
end


for i = 1:n
   r = rand(1,1);
	if r > 0.5
   	r1 = floor(nDes*r);
	else
   	r1 = ceil(nDes*r);
   end
   
   for j = 1:m
      if(j == r1) 
         XX(i,j) = x(j);
      end
   end
end
ret = XX;