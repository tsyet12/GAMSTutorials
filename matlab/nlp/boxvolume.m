function v=boxvolume(h,a,b)
%
% returns the volume of a box made from
% a sheet of paper with size a x b
% The box hight is h
%
v = -h*(b - 2*h)*(a - 2*h);
