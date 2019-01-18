% checking lowerbound constraint violation           
   for bmin = 1:10
         
      igood = 1;
    	for i = 1:n
         if Xmin(i) > xnew(i)
            igood = -1;
            break;
         end
      end
      if igood == 1
         break;
      else
       	xnew= xnew(2.0;
      end
   end
      
   % A similar structure for testing the upper bound
      
   for bmax = 1:10
         
         igood = 1;
      	for i = 1:n
            if Xmax(i) < xnew(i)
               igood = -1;
               break;
            end
         end
         if igood == 1
            break;
         else
         	newa = newa/2.0;
         end
      end
