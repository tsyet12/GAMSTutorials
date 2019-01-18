function r = SDPr2(i,j,a)
% (c) jskl UoM
%
% SDPr2 returns the immediate reward r(i,j,a) (Tijms maintenance example)
%
% Arguments: 
% i,j = states
% a = action
%
% Returns:
% r = r(i,j,a)
%
switch a
   case 1
      r = 0;
   case 2
      r = 0;
      if j==1
         if (i==2)||(i==3)
            r = -7;
         elseif i==4
            r = -5;
         end
      end
   case 3
      r = 0;
      if (i==5)&&(j==6)
         r = -10;
      end
   otherwise
      disp('SDPr2: wrong action number.')
end
