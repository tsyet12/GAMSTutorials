% Drawing linear constraints for LP programming problems
% Dr. P.Venkataraman
% Optimization Using Matlab
% Chapter 3 - linear Programming
%
% Lines are represented as: ax + by = c ( c >= 0)
% x1, x2 indicate the range of x for the line
% typ indicates type of line being drawn l (<=)
%                                        g, (>=)
%                                        n  (none)
%
% The function will draw line(s) in the figure window
% the green line represents the actual value 
% of the constraint
% the red dashed line is 10 % larger or smaller
% (in lieu of hash marks)
% the limit constraints are identifies in magenta color
% the objective function is in blue dashed lines
%
function ret = drawLine(x1,x2,a,b,c,typ)

% recognize the types and set color
if (typ == 'n') 
   str1 = 'b';
   str2 = 'b';
   cmult = 1;
elseif (typ == 'e')
      str1 ='m';
      str2 ='m';
 else
   str1 = 'g';
   str2 = 'r';
end

% values for drawing hash marks
% depending on the direction of inequality
if (typ ~= 'n' | 'e') 
   if (typ == 'l')
      cmult = +1;
   else cmult = -1;
   end
end

% set up a factor for drawing the hash constraint
if (abs(c) >= 10)
   cfac = 0.025;
elseif (abs(c)> 5) & (abs(c) <  10)
   cfac = 0.05;
else
   cfac = 0.1;
end

if (c == 0 ) 
   cdum = cmult*0.1; 
else
   cdum = (1 + cmult* cfac)*c;
end

% if b = 0 then determine end points of line x line
if ( b ~= 0)
   y1 = (c - a*x1)/b;
   y1n = (cdum - a* x1)/b;
   y2 = (c - a* x2)/b;
   y2n = (cdum - a*x2)/b;
else
   % identfy limit constraints by magenta color
   str1 = 'm';
   str2 = 'm';
   y1 = x1; % set  y1 same length as input x1
   y2 = x2;  % set y2 same length as input x2
   x1 = c/a;  % adjeust x1 to actual value
   x2 = c/a;  % adjust x2 to actual value
   y1n = 0;  % set y = 0;
   y2n = 0;  % set  y = 0
end

if (a == 0) 
   str1 = 'm'; % set color for limit line
   str2 = 'm'; % set color for limit line
end;
% draw axis with solid black color

hh = line([x1,x2],[0,0]);
set(hh,'LineWidth',1,'Color','k');

hv = line([0,0],[x1,x2]);
set(hv,'LineWidth',1,'Color','k');

% start drawing the lines

h1 = line([x1 x2], [y1,y2]);

if (typ == 'n') 
   set(h1,'LineWidth',2,'LineStyle','--','Color',str1);
else
   set(h1,'LineWidth',1,'LineStyle','-','Color',str1);
end

if (b ~= 0)&(a ~= 0)
   text(x1,y1,num2str(c));
end
if( b == 0)|(a == 0)| (typ == 'n') | (typ == 'e')
   grid
   ret = [h1];
   return, end 
grid;
h2 = line([x1 x2], [y1n,y2n]);
set(h2,'LineWidth',0.5,'LineStyle',':','Color',str2);
grid
hold on
ret = [h1 h2];

