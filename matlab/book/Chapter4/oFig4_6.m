% Unconstrained Optimization%  
%	Dr. P.Venkataraman
%
%	section 4.3.1, Figure 4.5
% additional graphics through plotedit
%

x1=0:.05:4;	
x2=0:0.05:4;
[X1 X2]=meshgrid(x1,x2); % X,Y are matrices

fval=-X1.*X2;	% could have used an m-file

[c1,h1]= contour(x1,x2,fval,[-9 -8 -5 -3 -1],'k');
% draws the specified contours
% and establishes handles to set properties of plot               
set(h1,'LineWidth',1);
axis([0 4 0 4]);
clabel(c1);	% labels contours
xlabel('x_1');
ylabel('x_2');

% draw the design space
line([0 3],[0 0],'Color','b', ...
      'LineWidth',1);
line([3 3],[0 3],'Color','b', ...
      'LineWidth',1);
line([3 0],[3 3],'Color','b', ...
      'LineWidth',1);
line([0 0],[3 0],'Color','b', ...
      'LineWidth',1);

hold on 
plot(3,3,'mo')
text(3.05,3.05,'(x_1^*,x_2^*)')
hold off
