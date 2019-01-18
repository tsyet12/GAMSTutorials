load orig.dat;
load myairfoil.dat;
load vertices.dat;

h0 = plot(vertices(:,1),vertices(:,2),'g:');
hold on;
plot(vertices(:,1),vertices(:,2),'o', ...
   'MarkerFaceColor','m');
h1 = plot(orig(:,1),orig(:,2),'r-');
set(h1,'LineWidth',1);
h3 = plot(myairfoil(:,1),myairfoil(:,2),'b')
xlabel('x/c')
ylabel('y/c')