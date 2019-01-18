%  Applied Optimization with MATLAB
%  Chapter 4, Section 4.1
%  Graphical representation of Example 4.1

% draw the ellipse
x1=0:0.05: 2.0;
x2=0:0.05:1.0;
[X1,X2]=meshgrid(x1,x2);
ellipse= create_ellipse(X1,X2);
[c1,h1]=contour(x1,x2,ellipse,[0,0]);
set(h1,'LineWidth',2)
% draw the linear constraint
l1=line([0 1.5],[2 0]);
set(l1,'Color','r','LineWidth',2);

% draw the axis
l2 =line([-1 3],[0 0]);
set(l2,'Color','k','LineWidth',1);
l3 =line([0 0],[-1 3]);
set(l3,'Color','k','LineWidth',1);

%  change the axis
axis([0 3 0 3]);

% locate the design variables and mark area
line([0 0.75],[0.5 0.5]);
line([0.75 0.75], [0 0.5]);
text(0.6,0.6,'(x_1,x_2)');
%mark axis
text(2.3,-0.25,'x_1')
text(-0.25,2.3,'x_2')