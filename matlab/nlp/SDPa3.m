function ai = SDPa3(i)
% (c) jskl UoM
%
% SDPa3 returns actions for state i (recycling robot example)
%
% Arguments: 
% i = status
%
% Returns:
% ai = set (vector) of actions for state i
%
switch i
   case 1
      ai = [1 2];
   case 2
      ai = [1 2 3];
   otherwise
      disp('SDPa3: wrong state number.')
end
