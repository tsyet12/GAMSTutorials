x1=0.02:.1:20;
x2=0.025:0.1:20;
[X1 X2]=meshgrid(x1,x2);
ineq1=g1sc(X1,X2);
ineq3=g3sc(X1,X2);
contour(x1,x2,ineq1,[0,0],'r-');
hold on
contour(x1,x2,ineq3,[0,0],'b-');
hold off

x0=[7 6];
x=fsolve('g1g3',x0)