% (c) jskl UoM
%
% "simplex" Solves the LP problem: Max z=c'x, ST Ax <= b, x>=0
%            by table approach
% (fast version, shows just final results)
%
% Prepare: A (m x n matrix, no slacks !)
%          b (m vector - RHS)
%          c (n vector - objective coefficients)
% Then just run >>simplex
%
% Example: A=[4 2;3 5;1 1],b=[100 150 50]',c=[ 4 5]'
% (Run script "prepare_ex1")
%
% preparation:
[m n]=size(A); % take the size of A
a=[A eye(m)];  % add slacks to A
cc=[c; zeros(m,1)];  % add zeros to c
% initil basic index set:
Ib=[n+1:n+m];
update;
[rcmin,col]=min(rc);
while rcmin < 0
   ratio;
   [ratmin,row]=min(ra);
   while ratmin < 0   % eliminate negative ratios
      ra(row)=Inf;
      [ratmin,row]=min(ra);
   end;
   if ratmin == Inf
      disp('Unbounded model! Check the input.')
      return
   end
   Ib(row)=col;
   update;
   [rcmin,col]=min(rc);
end;
sresults
