% Unconstrained Optimization%  
%	Dr. P.Venkataraman
%
%	section 4.3.3, Figure 4.8
% additional graphics using plotedit command

x1=0:.05:4;	
x2=0:0.05:4;
[X1 X2]=meshgrid(x1,x2); % X,Y are matrices

fval=-X1.*X2;	% could have used an m-file
g1val= 20*X1+15*X2-30;
g2val= 0.25*X1.*X1 +X2.*X2 -1;
[c1,h1]= contour(x1,x2,fval,[-9 -5 -1 -0.7443 -0.5  ],'k');
% draws the specified contours
% and establishes handles to set properties of plot               
set(h1,'LineWidth',1);
hold on
[c2,h2]= contour(x1,x2,g1val,[0 0],'m--');
set(h2,'LineWidth',2);


[c3,h3]= contour(x1,x2,g2val,[0 0],'m--');
set(h3,'LineWidth',2);

axis([0 4 0 4]);
clabel(c1);	% labels contours
xlabel('x_1');
ylabel('x_2');

% draw the design space
line([0 3],[0 0],'Color','b', ...
      'LineWidth',2);
line([3 3],[0 3],'Color','b', ...
      'LineWidth',2);
line([3 0],[3 3],'Color','b', ...
      'LineWidth',2);
line([0 0],[3 0],'Color','b', ...
      'LineWidth',2);

% solution

hold off
grid

