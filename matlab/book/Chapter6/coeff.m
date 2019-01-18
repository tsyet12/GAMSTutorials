%	This file calculates the Bezier coefficient Matrix
%	based on the order of the curve - oc
% it returns a (oc + 1) * (oc + 1) matrix 
function returnvalue = coeff(oc)

% initialize the vector
for i = 1:oc + 1
   for j = 1:oc + 1
      A(i,j) = 0.0;
   end
end

for  i = 0:oc
	ii = i + 1;
   for j = 0:oc - i
      jj = j + 1;
      A(ii,jj) = Combination(oc,j)*Combination(oc - j,oc -i-j)*(-1)^(oc-i-j);
   end
end
returnvalue =A;



