function a=downpivot(A,r,c)
% pivot matrix A at row r and column c down
% for zero pivot item no operation
% no other tests
x=A(r,c);
if x ~= 0
 rmax=length(A(:,1));
 A(r,:)=A(r,:)/x;
 for i=r+1:rmax
   A(i,:)=A(i,:)-A(r,:)*A(i,c);
 end
end
a=A;
