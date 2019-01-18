function p = SDPP2(i,j,a)
% (c) jskl UoM
%
% SDPP2 returns the transition probability p(i,j,a) (Tijms maintenance example)
%
% Arguments: 
% i,j = states
% a = action
%
% Returns:
% p = p(i,j,a)
%
p = 0;
switch a
   case 1
      if i<5
         if j<6
            pij = [0.9 0.1 0 0 0;0 0.8 0.1 0.05 0.05; 0 0 0.7 0.1 0.2; 0 0 0 0.5 0.5];
            p = pij(i,j);
         end
      end
   case 2
      if j==1
         if (i>1)&&(i<5)
            p = 1;
         end
      end
   case 3
      if i==5
         if j==6
            p = 1;
         end
      elseif i==6
         if j==1
            p = 1;
         end
      end
   otherwise
      disp('SDPP2: wrong action number.')
end
