% Illustration of the Taylor series for one variable
%  Optimization Using MATLAB
%	Dr. P.Venkataraman
%
%	section 4.2.3
% The graphics are generated in the code

syms x
f= 12 + (x-1)*(x-1)*(x-2)*(x-3);

% taylor is a symbolic function that generates
% the taylor approximation approximation
% usage here taylor(function,order,point t which to expand) 
% the functions are expanded about the point 2.5

t1=taylor(f,1,2.5); % expansion with first term

t2=taylor(f,2,2.5);  % linear expansion
t3=taylor(f,3,2.5);  % quadratic expansion
t6=taylor(f,6,2.5);	% fifth order expansion

xd=0:.05:4;	
fval=double(subs(f,x,xd)); % original function

c1=plot(xd,fval);
set(c1,'LineWidth',2,'Color','r', 'LineStyle','-');
hold on

ezplot(t1,[0,4]); %plot constant approximation
ezplot(t2,[0,4]); % plot linear expansion
ezplot(t3,[0,4]); % plot quadratic expansion
ezplot(t6,[0,4]); % plot fith order expansion

text(0.5,12,'constant');
text(0.75,13.5,'linear')
text(2.5,17,'fifth-order and original')
text(0.5,22,'quadratic');
grid

xlabel('x')
ylabel('f and Taylor expansion about 2.5')
title('Approximation using Taylor series')



hold off