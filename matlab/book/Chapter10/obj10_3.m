function [f, grad] = obj10_3(x)
global t yc

% the objective function
f = 0;
for i = 1:length(t)
   f = f + (yc(i) - (x(1)*t(i)^2+x(2)*t(i)+x(3)))^2;
end

% the gradients of the objevtive function
dfd1 = 0;
dfd2 = 0;
dfd3 = 0;

for i = 1:length(t)
   dfd = 2*(yc(i) - (x(1)*t(i)^2+x(2)*t(i)+x(3)));
   dfd1 = dfd1 - dfd*t(i)*t(i);
   dfd2 = dfd2 - dfd*t(i);
   dfd3 = dfd3 - dfd;
end
 grad = [dfd1 dfd2 dfd3];