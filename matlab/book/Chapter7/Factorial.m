% M - file for factorial
function returnvalue = Factorial(m)

if ( m == 0) 
	returnvalue = 1;
else
   returnvalue = m * Factorial(m-1);
end