function hanoi(n,from,to,using)
% (c) jskl UoM
%
% Tower of Hanoi problem solution.
% Moving tower of height n from "from" to "to" by using "using"
% n integer, the others strings
%
% Just shows the moves
%
% Example use: hanoi(4,'L','R','C')
%
if n>0
    hanoi(n-1,from,using,to);
    display(['Move disk ' int2str(n) ' from ' from ' to ' to]);
    hanoi(n-1,using,to,from);
end