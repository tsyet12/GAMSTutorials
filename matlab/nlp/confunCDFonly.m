         function c = confunCDFonly(x)
         if x(1)<2 | x(2)<1 
           c = 0; 
         else
           if x(1)<4
             if x(2)<3 
               c = 0.1;
             else
               if x(2)<7
                 c = 0.2;
               else
                 c = 0.25;
               end
             end
           else
             if x(1)<8
               if x(2)<3
                 c = 0.2;
               else
                 if x(2)<7
                   c = 0.6;
                 else
                   c = 0.75;
                 end
               end
             else
               if x(2)<3
                 c = 0.25;
               else
                 if x(2)<7
                   c = 0.8;
                 else
                   c = 1;
                 end
               end
             end
           end
         end
