% Example 5.1 and 5.1.a	
% Numerical Techniques - 1 D optimization
% Optimzation with MATLAB, Section 5.2.3
% Bisection Method
% Dr. P.Venkataraman
%
%	

%define f, phi
syms  al f phi phial
f = (al-1)^2*(al-2)*(al-3);
phi = diff(f);

% plot of overall function
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

%number of iterations = 20

aone(1) = 0.0; al = aone(1); phi1(1) = subs(phi);
atwo(1) = 4.0; al = atwo(1); phi2(2) = subs(phi);

% display the trapping of the functions for the first sevel iterations
figure

% organizing columns
% values are stored in a vector for later printing
fprintf('iterations    alpha-a    alpha-b    alpha   phi(alpha)    f\n')
for i = 1:20;
   index(i) = i;
   al = aone(i) + 0.5*(atwo(i) - aone(i)); % step 2
   
   % step 3
   alf(i) = al;
   phi_al(i) =subs(phi);
   fun(i) = subs(f);
   if ((atwo(i) - aone(i)) <= 1.0e-04)
      break;
   end

   if (abs(phi_al) <= 1.0e-08)
      break;
   end
  
      
   if ((phi1(1)*phi_al(i)) > 0.0) 
      aone(i+1)=al;atwo(i+1) = atwo(i);
      phi2(i+1)=phi2(i); phi1(i+1) = phi_al(i);
   else atwo(i+1)=al; phi2(i+1) = phi_al(i);
      aone(i+1) = aone(i); phi1(i+1)=phi1(i);
   end
      
   
   %  plots of th technique/trapping minimum
   if (i <=7)
   	ezplot(phi,[aone(i),atwo(i)])
   	xlabel('\alpha')
		ylabel('\phi(\alpha)')
		title('Example 5.1')

   	l1=line([aone(i) aone(i)], ...
         [0,phi1(i)]);
   	set(l1,'Color','r','LineWidth',1)
      
      l2=line([atwo(i) atwo(i)], ...
      	[0,phi2(i)]);
   	set(l2,'Color','g','LineWidth',1)
      
      l3=line([aone(i) atwo(i)],[0 0]);
		set(l3,'Color','k','LineWidth',1,'LineStyle','-')

   	axis([0.8*aone(i) 1.2*atwo(i) phi1(i) phi2(i)])
   	pause(2)
   end
     
end

% print out the values
disp([index' aone' atwo' alf' phi_al' fun'])
   




