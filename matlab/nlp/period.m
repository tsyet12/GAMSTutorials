% This script shows the period of the LCG generator of Matlab
% c gets the value 2^31 - 2 = 2147483646
rand('seed',1);
c = 1;
time = cputime;
x = rand;
while rand ~= x
    c = c+1;
end
time = cputime - time;
display(['Period = ' num2str(c)]);
display(['Time of going through the period = ' num2str(time) ' [s]']);


