%% ENGR 4020: Lecture 28 State Space Control Example
% from http://ctms.engin.umich.edu/CTMS/index.php?example=Introduction&section=ControlStateSpace
close all
clear all
clc

% Define the system
A = [ 0   1   0
     980  0  -2.8
      0   0  -100 ];

B = [ 0
      0
      100 ];

C = [ 1 0 0 ];

% Check stability: are all poles in RHP?
poles = eig(A)

% Define parameters for simulation
t = 0:0.01:2;
u = zeros(size(t));
x0 = [0.01 0 0];

% Open loop system
sys = ss(A,B,C,0);

% Simulate the linear system response (no reference input), u=0s
[y,t,x] = lsim(sys,u,t,x0);
plot(t,y)
title('Open-Loop Response to Non-Zero Initial Condition')
xlabel('Time (sec)')
ylabel('Ball Position (m)')

% Can we control the system?
if rank(ctrb(A,B))==length(eig(A))
    disp('system is controllable!')
end

% Want a stable system with settling time under 0.5 s and MP(%)<5%
% can figure out zeta from MP(%) requirement. Lets try these poles
% the zeta we find should be corresponding to 45 degrees
p1 = -10 + 10i;
p2 = -10 - 10i;
p3 = -50;

% close the loop
K = place(A,B,[p1 p2 p3]);
sys_cl = ss(A-B*K,B,C,0);

% simulate the system
lsim(sys_cl,u,t,x0);
xlabel('Time (sec)')
ylabel('Ball Position (m)')

% this doesn't meet characteristics, let's move everything further into RHP
p1 = -20 + 20i;
p2 = -20 - 20i;
p3 = -100;

K = place(A,B,[p1 p2 p3]);
sys_cl = ss(A-B*K,B,C,0);

lsim(sys_cl,u,t,x0);
xlabel('Time (sec)')
ylabel('Ball Position (m)')
% this gets closer :) 

% now let's apply a step input (u) and simulate
t = 0:0.01:2;
u = 0.001*ones(size(t)); % non zero input (all ones!)

sys_cl = ss(A-B*K,B,C,0);

lsim(sys_cl,u,t);
xlabel('Time (sec)')
ylabel('Ball Position (m)')
axis([0 2 -4E-6 0])
% this has terrible e_ss.  we need to scale

Nbar = rscale(sys,K) % grab this function from the CMS.  rescale to track step

% sim one more time to get decent results!
lsim(sys_cl,Nbar*u,t)
title('Linear Simulation Results (with Nbar)')
xlabel('Time (sec)')
ylabel('Ball Position (m)')
axis([0 2 0 1.2*10^-3])

