xb=B\b;     % updates items normally found in the simplex table
z=cb'*xb;   % objective
wT=cb'/B;   % simplex multipliers 
rc=wT*a-cc';% reduced costs
