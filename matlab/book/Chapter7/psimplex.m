% simplex method
format compact
clear
%A=[1 2 3 0;2 1 5 0;1 2 1 1]; B = [15 20 10];C=[-1 -2 -3 1];
A = [5 3 1.5 0 1 0;1.8 -6 4 1 0 -1;-3.6 8.2 7.5 5 0 0];
B = [8 3 15];
C = [-2 -5 4.5 -1.5 0 0];
n = 6; m = 3;


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
u;

stop = 0;
x;
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
A
C
w
x 