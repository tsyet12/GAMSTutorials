% Example 5.1 and 5.1.a	
% Numerical Techniques - 1 D optimization
% Optimzation with MATLAB, Section 5.2.2
% Newton - Raphson Technique
% Dr. P.Venkataraman
%
%	

syms  al f g phi phial
f = (al-1)^2*(al-2)*(al-3);
g = -1 - 1.5*al + 0.75*al*al;
phi = diff(f);
phial = diff(phi);
ezplot(f,[0 4])
l1 =line([0 4],[0 0]);
set(l1,'Color','k','LineWidth',1,'LineStyle','-')
hold on
ezplot(phi,[0 4])
grid
hold off
xlabel('\alpha')
ylabel('f(\alpha), \phi(\alpha)')
title('Example 5.1')
axis([0 4 -2 10])

alpha(1) = 0.5;
fprintf('iterations    alpha    phi(i)     d(alpha)    phi(i+1)     f\n')
for i = 1:20;
   index(i) = i;
   al = alpha(i);
   phicur(i)=subs(phi);
   delalpha(i) = -subs(phi)/subs(phial);
   al = alpha(i)+delalpha(i);
   
   phinext(i)=subs(phi);
   fun(i)=subs(f);
   if (i > 1)
      l1=line([alpha(i-1) alpha(i)], [phicur(i-1),phicur(i)]);
       set(l1,'Color','r','LineWidth',2)
       pause(2)
    end

   
   if (abs(phinext(i)) <= 1.0e-08) 
      disp([index' alpha' phicur' delalpha' phinext' fun'])
      
     		return
   else
      alpha(i+1)=al;
   end
end
i



