%  Applied Optimization using MATLAB
%  Dr. P.Venkataraman
%	Publisher: John Wiley
%
%	Balas zero-one addittive algorithm
%	Interger (zero/one) Programming
%	Based on the PASCAL version by 
%  M M Syslo, N Deo, J. Kowalik in the book
%	Discrete Optimization Algorithms with Pascal Programs
%
%	Minimize	z = c1x1 + c2x2 + ... + cnxn,   c(j) >= 0
%
%	Subject to:     a(i,j)*x(j) <= b(i), i = 1, 2, ..., m
%														j = 1, 2, ..., n
%						x(j) =  0 or 1				j = 1, 2, ..., n
%
%-----------------------------------------------------------
format compact
clear
clc
%x = [0 0 0 0]% identify the number of variables
string1 = ['N : Number of design variables:  '] ;
N = input(string1);
fprintf(' The number of design variables entered:  %3i',N);
fprintf('\n')
clear string1;
%  identify the number of constraints
string1 = ['M : Number of constraints:  '] ;
M = input(string1);
fprintf(' The number of constraints entered is :  %3i',M);
fprintf('\n')
clear string1;
% enter the coefficients of the constraint matrix
string1 = ['A(N,M) : Matrix of Constraint Coefficients:'];
A = input(string1);
fprintf(' The coefficient matrix  A \n')
disp(A)
fprintf('\n')
clear string1;
sizeA = size(A);

if (sizeA(1,1) ~= M) | (sizeA(1,2) ~= N) 
   fprintf('Error : Coefficient Matrix Dimension is in error \n')
   fprintf('Check problem, clear,  and re- start\n')
end

% enter the vector of cost coefficients
string1 = ['C(N) : vector of non-negative cost coefficients:  '] ;
C = input(string1);
fprintf(' The cost coefficient vector  C \n')
disp(C)
sizeC = size(C);
if (sizeC ~= N) 
   fprintf('Error : Cost Coefficient Vector dimension is in error \n')
   fprintf('Check problem, clear,  and re-start\n')
end

fprintf('\n')
clear string1;

string1 = ['B(M) : the right hand side vector: '] ;
B = input(string1);
fprintf(' The right hand side vector  B \n')
disp(B)
sizeB = size(B);
if (sizeB ~= M) 
   fprintf('Error : right hand side vector dimension is in error \n')
   fprintf('Check problem, clear,  and re-start\n')
end

fprintf('\n')
clear string1;

%  program starts here
%  Initialization

for i = 1:M
   y(i) = B(i);
end
z = 1;
for j = 1:N
   xx(j) = 0;
   z = z + C(j);
end
fval = z + z;

% initialize s,t,z,kk, and exist
s = 0; t = 0; z = 0; kk(1) = 0; exist =0;
GOTO20 = 0;
% see if the go to statement can be handled by  a while ststement
loop10 = 1;
%for outloop = 1:2 
while loop10 == 1
      GOTO20 = 0;
      p = 0; mnr = 0;
   for i = 1:M
      r = y(i);
      if r < 0      % infeasible constraint
         p = p + 1;  gamma = 0;  beta = -inf;
         alpha = r;
         for j = 1: N
            if xx(j) <= 0
               %[i j]
               if (C(j)+z) >= fval
                  xx(j) = 2;
                  kk(s+1) = kk(s+1) + 1;
                  t = t +1;
                  jj(t) = j;
               else
                  r1 = A(i,j);
                  if r1 < 0
                     alpha = alpha - r1;
                     gamma = gamma + C(j);
                     if beta < r1
                        beta = r1;
                     end % end if beta
                  end  % end if r1 < 0   
               end      %  C(j) + z < fval  
            end   % end if xx(j) < 0
         end   % end for j = 1:N
         %fprintf(' alpha: %6.2f\n ',alpha)
         if alpha < 0	
            breakalpha = 1;   % break out of i loop
            %fprintf('go to 20 since alpha < 1 and r1 >= 0 \n');
            GOTO20 = 1;
            break
         end
         %GOTO20
         %fprintf('alpha + beta  : %6.2f \n',alpha + beta)
         if (alpha + beta) < 0
            if gamma + z >= fval
					breakalphabeta = 1;   % break out of i loop
            	%fprintf('go to 20 since gamma + z >= fval and r1 >= 0 \n');
            	GOTO20 = 1;
               break
            end
            %GOTO20
				for j = 1:N
               r1 = A(i,j);
               r2 = xx(j);
               if r1 < 0
                  if r2 == 0
                     xx(j) = -2;
                     breakznr = 0;
                     for nr = 1:mnr
                        zr(nr) = zr(nr) -A(w(nr),j);
                        %fprintf('z(nr) = %6.2f \n',z(nr))
                        if zr(nr) < 0   % go to 20
                           breakznr = 1;
                           %fprintf('go to 20 since z(nr) < 0  and r2 = 0 \n');
                           GOTO20 = 1;
                           break
                        end
                     end
                     % handle a break to 20
                     if breakznr == 1
                        GOTO20 =1;
                        break
                     end   
                  end   
               else
                  if r2 < 0
                     alpha = alpha - r1;
                     breakalphai = 0;
                     %fprintf(' alpha: %6.2f\n ',alpha)
         				if alpha < 0	
            				breakalphai = 1;   % break out of i loop
            				%fprintf('go to 20 since alpha < 1 and r2 < 0 \n');
            				GOTO20 = 1;
                        break
                     end
                     breakgamma = 0;
                     gamma = gamma + C(j);
                     %fprintf(' gamma : %6.2f\n ',gamma)
                     if gamma + z >= fval
								breakgamma = 1;  % break out of i loop
            				%fprintf('go to 20 since gamma + z >= fval and r2 < 0 \n');
            				GOTO20 = 1;
               			break
                     end
                   end   
               end
            end     % end j loop
               % have to break on GOTO2O == 1
            if (breakznr == 1)| (breakalphai == 1) | (breakgamma == 1)
               %fprintf (' breaking out of the j loop \n')
               % now break out of the i loop
               break;
            end
            % in i loop now
            mnr = mnr + 1;
            w(mnr) = i;
            zr(mnr) = alpha;
         end      % if alpha + beta  < 0   
      end    %  if r < 0
   end    % end i loop
   %  execute GO TO 20  loop 
   GOTO20;
   if GOTO20 == 1
      %fprintf(' in the first Go TO 20 loop \n')
      for j = 1:N
      	if xx(j) < 0
         	xx(j) = 0;
      	end     % if x(jj) < 0
   	end     % for j = 1:N
   	if s > 0
      	while (ii(s) < 0)  | (s  == 0);
          	p = t;
          	t = t - kk(s + 1);
          	for j = t + 1:p
              xx(jj(j)) = 0;
          	end   % for j = t ...
          	p = abs(ii(s));
          	kk(s) = kk(s) + p;
          	for j = t - p + 1:t
            	p = jj(j);
            	xx(p) = 2;
            	z = z - C(p);
             	for i = 1:M
               	y(i) = y(i) + A(i,p);
            	end   % for i = 1...
         	end      % for j = t
         	s = s-1;
      	end   % while ....
      end     % if s > 0
      s
    	if s <= 0
      	loop10 = 2;
      	break
   	else
      	loop10 = 1;
      	break
      end
   end     % end GOTO20 loop  
   GOTO20 = 0;
   breakx = 0; 
   %p
   %mnr
   if p == 0		% updating the best solution
      while breakx == 0
      	fval = z;
     		exist = 1;
      	for j = 1:N
         	if xx(j) == 1;
            	x(j) = 1;
         	else
            	x(j) = 0;
         	end
        		breakx = 1 ;  % break out of j loop to execute go to loop 20
         	%fprintf('p = 0 - updating best solution \n')
            GOTO20 = 1;
            break
      	end  % for j = 1:N
      end   % while
   end    % if p == 0
   if breakx == 0
      breakmnr = 0;
      
      while breakmnr ==0
         if mnr == 0
            p = 0;
         	gamma = -inf;
         	for j = 1:N
            	if xx(j) == 0
               	beta = 0;
               	for i = 1:M
                  	r = y(i);
                  	r1 = A(i,j);
                  	if r < r1
                    		beta = beta + r -r1;
                  	end
               	end
               	r = C(j);
               	if (beta > gamma) | ((beta == gamma) & (r < alpha))
                  	alpha = r;
                  	gamma = beta;
                  	p = j;
               	end
            	end   % xx(j) == 0   
            end    % j = 1: N
            %fprintf(' p: %6.2f\n ',p)
         	if p == 0
          	   breakmnr = 1;   % break out of mnr loop to execute  20
         		%fprintf('p ==0 in nmr = 0 \n');
            	GOTO20 = 1;
               break
            end
            s = s + 1;
            kk(s + 1) = 0;
            t = t + 1;
            jj(t) =p;
            ii(s) = 1;
            xx(p) = 1;
            z = z + C(p);
            for i = 1:M
               y(i) = y(i) - A(i,p);
            end
            break
         else	% if mnr == 0
            %fprintf('\n else loop for mnr ==0 \n')
            s = s + 1;
            ii(s) = 0;
            kk(s+1) = 0;
            for j = 1:N
               if xx(j) < 0
                  t = t + 1;
                  jj(t) = j;
                  ii(s) = ii(s) - 1;
                  z = z + C(j);
                  xx(j) = 1;
                  for i = 1:M
                     y(i)= y(i) - A(i,j);
                  end
               end    % if xx(j) <0
            end    % for j = 1 ..
            break
         end     % if nmr == 0
      end     % while ...
   end   %   breakx == 0     
   % postpone handling GO TO 20
   
   %breakx
   %breakmnr
   if (breakx == 1 ) | (breakmnr == 1)
      %fprintf('\n I am in breakx == 1 loop \n')
      for j = 1:N
      	if xx(j) < 0
         	xx(j) = 0;
      	end     % if x(jj) < 0
   	end     % for j = 1:N
      if s > 0
         while (ii(s) < 0) | (s  == 0)
          	p = t;
          	t = t - kk(s + 1);
          	for j = t + 1:p
              xx(jj(j)) = 0;
          	end   % for j = t ...
          	p = abs(ii(s));
          	kk(s) = kk(s) + p;
          	for j = t - p + 1:t
            	p = jj(j);
            	xx(p) = 2;
            	z = z - C(p);
             	for i = 1:M
               	y(i) = y(i) + A(i,p);
            	end   % for i = 1...
         	end      % for j = t
         	s = s-1;
      	end   % while ....
      end     % if s > 0
      %s
    	if s <= 0
          loop10 = 2;
          %z
          %p
      	break
   	else
         %loop10 = 1
         %z
         %p
      	break
      end
   end    % if breakx  == 1 ..   
end    % while  loop10 == 1 
%fprintf('\n after while loop10 \n')
%loop10
%xx
%fval
%if loop10 == 2
 %  break
%end   
%end  % for outloop ..
%fprintf('\n after outer  for loop')
%loop10

if exist == 1
   fprintf('\n Solution exists \n------------------')
else
   fprintf('\n NO Solution \n----------')
end

fprintf('\n The variables are : \n')
disp(xx)
fprintf('\n The objective function :%6.2f \n',fval)

cons = A*xx';
fprintf('\nConstraints   - Value and Right hand side \n')
disp  ([cons B'])

            
            