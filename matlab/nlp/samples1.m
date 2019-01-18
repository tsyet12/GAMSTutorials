function y = samples1(samples,investment,periods,rate,sigma)
% (c) jskl UoM
%
% Repeated investment simulation
%
% y = array with generated samples (simulation results)
%
% samples = number of generated samples
% investment = initial deposit
% periods = number of interest deposits
% rate = mean interest rate per period in [%] (normally distributed)
% sigma = interest rate standard deviation in [%]
%
% Ex: y = samples1(10000,1000,10,4,0.5);
%     hist(y,[1300:5:1600])
%
y = zeros(samples,1);
for i=1:samples
   x = investment;
   for j=1:periods
      x = x*(1 + (randn*sigma + rate)/100);
   end
   y(i) = x;
end
    


