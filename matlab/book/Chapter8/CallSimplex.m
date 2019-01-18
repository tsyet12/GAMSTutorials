%  Applied Optimization using MATLAB
%  Dr. P.Venkataraman
%	Publisher: John Wiley
%
%	Revised Simplex Algorithm translated from PASCAL from
%	Discrete Optimization Algorithms
%	M. M. Syslo, N. Deo, J  Kowalik, Prentice Hall
%
%	Minimize	z = c1x1 + c2x2 + ... + cnxn, 
%
%	Subject to:     a(i,j)*x(j) = b(i), i = 1, 2, ..., m
%														j = 1, 2, ..., n
%						x(j) >= 0				j = 1, 2, ..., n
%	it is expected that b(i) > 0
%	The program handles artificial variables automatically
%  Problem can be set up with negative slack variables
%
%   This is a Call version m-file
%	Problem needs to be described through the 
%	coefficient matrices A, B, C, 
%	along with the significant dimensions M, N
%  returns 
%-----------------------------------------------------------
function [xsol, f]  = CallSimplex(A,B,C,M,N)
format compact
%A=[1 2 3 0;2 1 5 0;1 2 1 1]; B = [15 20 10];C=[-1 -2 -3 1];
%A = [5 3 1.5 0 1 0;1.8 -6 4 1 0 -1;-3.6 8.2 7.5 5 0 0];
%B = [8 3 15];%C = [-2 -5 4.5 -1.5 0 0];
n = N; m = M;

nofeas = 0;
nosol = 0;

p = m + 2;
q = m+2;
phase = 1;
k = m + 1;

for j = 1:n
   A(k,j) = C(j);
   s = 0;
   for i = 1:m
      s = s-A(i,j);
     
   end
    A(p,j) =s;
end


s = 0.0;
for i = 1:m
   w(i) = n + i;
   r = B(i);
   x(i) = r;
   s = s - r;
end

x(k) = 0.0;
x(p) = s;
for i = 1:p
   for j = 1:p
      u(i,j)=0.0;
   end
   u(i,i) = 1.0;
end

stop = 0;
while stop == 0
   if (x(p) >= -eps) & (phase == 1)
      phase = 0;
      q = m + 1;
   end
   
   d = 0.0;
   for j = 1: n
      s = 0.0;
      for i = 1: p
         s = s + u(q,i)*A(i,j);
      end   
      if d > s
         d = s;
         k = j;
      end
   end
   
   
   if d > -eps
      stop = 1;
      if phase == 1
         nofeas = 1
         break
      else   
         f = -x(q);
      end
   else
      for i = 1: q
         s = 0.0;
         for j = 1:p
            s = s + u(i,j)*A(j,k);
         
         end
         y(i) = s;
      end
      
      ex = 1;
      for i = 1:m
         if y(i) >= eps
            s = x(i)/y(i);
            if (ex ==1 ) | (s < d)
               d = s;
               l = i;
            end
            ex = 0;
         end
      end
      
      if (ex == 1)
         nosol = 1;
         stop = 1;
      else
         w(l) = k;
         s = 1.0/y(l);
         for j = 1:m
            u(l,j) = u(l,j)*s;
         end
         if l == 1
            i = 2;
         else
            i = 1;
         end
     
         while i <= q
            
            s = y(i);
            x(i) = x(i) - d*s;
            for j = 1: m
               u(i,j) = u(i,j) - u(l,j)*s;
            end
            if i == l - 1
               i = i + 2;
            else
               i = i + 1;
            end
         end
         x(l) = d;
      end
   end
end

if nofeas == 1
   fprintf('\n No feasible soluton')
else
   fprintf('\n The optimal basic variables are x(?): \n')
   disp(w)
   fprintf('\n Non basic variables are assumed to be zero')
   for i = 1:m
      xsol(i) = x(i);
   end   
   fprintf('\n The values of basic variables are:\n')
   disp(xsol)
   fprintf('\n Optimum value of the function: %8.4f\n ',f)
 end
 