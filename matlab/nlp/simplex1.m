% (c) jskl UoM
%
% "simplex1" Solves the LP problem: Max z=c'x, ST Ax <= b, x>=0
%            by matrix (no table) approach
% (shows all partial results with comments)
%
% Prepare: A (m x n matrix, no slacks !)
%          b (m vector - RHS)
%          c (n vector - objective coefficients)
% Then just run >>simplex1
%
% Example: A=[4 2;3 5;1 1],b=[100 150 50]',c=[ 4 5]'
% (Run script "prepare_ex1")
%
disp('preparation:')
[m n]=size(A) % take the size of A
a=[A eye(m)]  % add slacks to A
cc=[c; zeros(m,1)]  % add zeros to c
disp('initial basic index set:')
Ib=[n+1:n+m]
disp('updating B,cb:')
cb=cc(Ib)  % cb = basic part of c
B=a(:,Ib)  % B = basic matrix
disp('computing xb,z,wT,rc:')
xb=B\b     % xb = basic part of x
z=cb'*xb   % objective value
wT=cb'/B   % wT = simplex multipliers
rc=wT*a-cc'% rc = reduced costs
disp('minimum reduced cost:')
[rcmin,col]=min(rc) % find the minimum reduced cost
while rcmin < 0  % optimaliry test (at optimum all rc >= 0)
   disp('ratio test:')
   yk=B\a(:,col) % computing the yk column
   ra=xb./yk     % the ratios
   disp('selecting minimum ratio:')
   [ratmin,row]=min(ra)
   while ratmin < 0   % eliminate negative ratios
      ra(row)=Inf
      [ratmin,row]=min(ra)
   end;
   if ratmin == Inf
      disp('Unbounded model! Check the input.')
      return
   end
   disp('changing base (replacing the row-th basic index by col):')
   Ib(row)=col
   disp('updating base B and basic part of c cb:')
   cb=cc(Ib) 
   B=a(:,Ib)
   disp('computing new xb,z,wT,rc:')
   xb=B\b
   z=cb'*xb
   wT=cb'/B
   rc=wT*a-cc'
   disp('minimum reduced cost:')
   [rcmin,col]=min(rc)
end
disp('Results of simplex algorithm:')
objective=z
basic_variables=[Ib' xb]
shadow_costs=wT
reduced_costs=rc
