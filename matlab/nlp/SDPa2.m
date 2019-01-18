function ai = SDPa2(i)
% (c) jskl UoM
%
% SDPa2 returns actions for state i (Tijms maintenance example)
%
% Arguments: 
% i = status
%
% Returns:
% ai = set (vector) of actions for state i
%
switch i
   case 1
      ai = [1];
   case {2,3,4}
      ai = [1,2];
   case {5,6}
      ai = [3];
   otherwise
      disp('SDPa2: wrong state number.')
end
