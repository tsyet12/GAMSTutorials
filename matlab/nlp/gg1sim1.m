function [LQ,WQ,LQmax,WQmax,duration,L,W,rho,lambda,mu] = gg1sim1(intervals,services)
% (c) jskl UoM
%
% gg1sim1 = simulator of G/G/1 systems version 1.
%
% Simulation (statistics collection) starts by an idle period - first
% interval and ends by a busy period ended by the last service.
%
% Arguments:
% intervals = nonnegative intervals between arrivals, first arrival at intevals(1)
% services = nonnegative service durations for same customers (vectors of same lengths)
%
% Returns scalars [LQ,WQ,L,W,rho,lambda,mu] either
% found by simulation:
% LQ = mean number of waiting items (mean queue length) found by simulation
% WQ = mean waiting time found by simulation
% LQmax = maximum queue length
% WQmax = maximum waiting time
% duration = total experiment duration
%
% or computed:
% L = total mean system size = LQ + rho
% W = total mean time spent in the system = WQ + mean(services)
% rho = traffic rate (channel utilization) = lambda/mu
% lambda = arrival rate = 1/mean(intervals)
% mu = service rate = 1/mean(services)
%
% To use generate ints and servs, then: 
% [LQ,WQ,LQmax,WQmax,duration,L,W,rho,lambda,mu] = gg1sim1(ints,servs)
%
na = length(intervals);          % number of arrivals
if na~=length(services)
    display('Arguments don''t have the same length');
    return;
end
if na==0
    display('At least one arrival required');
    return;
end
if min(intervals)<0
    display('There is a negative interval');
    return;
end
if min(services)<0
    display('There is a negative service duration');
    return;
end
lambda = 1/mean(intervals);   % arrival rate
mu = 1/mean(services);        % service rate
rho = lambda/mu;              % traffic rate
if rho>1
    display('Unstable system - traffic rate is greater than 1');
    return;
end
% Simulation initialization
time = 0;                     % model time
nextarr = intervals(1);       % time of next (1st) arrival
iint = 1;                     % index of last used interval
iser = 0;                     % index of last used service duration
nexteos = 0;                  % time of next end of service, here none scheduled
sbusy = 0;                    % whether service is busy
qsize = 1000;                 % queue array size (big value)
queue = zeros(1,qsize);       % creating the queue array
qhead = 1;                    % points to the first item
qtail = 1;                    % points to the first free slot behind the last item
qlength = 0;                  % queue length
LQmax = 0;                    % maximum queue length
qlsum = 0;                    % queue length integral
qlsumt = 0;                   % queue length integral last update
WQmax = 0;                    % maximum waiting time
swtime = 0;                   % sum of waiting times
% Simulation run
while (nextarr>0)|(nexteos>0)
  if (nextarr<nexteos)&(nextarr>0)         % arrival to occur
    time = nextarr;           % advance time
    qlsum = qlsum + qlength*(time-qlsumt); % update queue length integral
    qlsumt = time;
    if iint<na                % more arrivals to be scheduled ?
      iint = iint+1;
      nextarr = time + interval(iint);     % scheduling the next arrival
    else
      nextarr = 0;            % no more arrivals
    end
    if (sbusy==0)             % service not busy
      sbusy = 1;
      iser = iser+1;
      nexteos = time + services(iser);     % scheduling the end of service
    else                      % queueing necessary
      qlength = qlength+1;
      queue(qtail) = time;    % record arrival time in queue }
      if (qtail==qsize) 
        qtail = 1;            % wrap around if end of array reached
      else  
        qtail = qtail + 1;
      end
      LQmax = max(qlength,LQmax);
    end
  elseif (nextarr>=nexteos)&(nexteos>0)    % end of service to occur
    time = nexteos;           % advance time
    qlsum = qlsum + qlength*(time-qlsumt); % update queue length integral
    qlsumt = time;
    if (qlength==0)           % queue empty
      sbusy = 0;
      nexteos = 0;            % this means no service scheduled
    else                      % start the next service, sbusy remains 1
      iser = iser+1;
      nexteos = time + services(iser);     % scheduling the end of service
      wtime = time - queue[qhead];         % waiting time
      swtime = swtime + wtime;
      WQmax = max(WQmax,wtime);
      if (qhead==qsize) 
        qhead = 1;            % wrap around if end of array reached
      else  
        qhead = qhead + 1;
      end
      qlength = qlength - 1;
    end
  end
end %of while
% Evaluation
duration = time;
LQ = qlsum/duration;
WQ = swtime/na;
W = WQ + mean(service);
L = LQ + rho;

