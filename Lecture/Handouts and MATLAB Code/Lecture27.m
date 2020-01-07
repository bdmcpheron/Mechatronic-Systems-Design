% Combined Feedback Control Example
close all
clear all
clc

% define the state space system
A = [0,1;16,0];
B = [0;1];
C = [1,0];
D = 0;

%% Full state feedback
% check controllability
Pc = ctrb(A,B);
if rank(Pc)==length(eig(A))
    disp('The system is Controllable')
end

% desired system
P = [-2+1i;-2-1i];

% place the poles for full state feedback
K = place(A,B,P);

% Construct the closed loop system
sys_full = ss(A-B*K,[0;0],C,0);

% simulate the system response to initial conditions
t_final = 5;
X0 = [-10;0];
[y_full,t_full,x_full] = initial(sys_full,X0,t_final);

%% Observer design
Po = obsv(A,C);
if rank(Po)==length(eig(A))
    disp('The system is Observable')
end

% specifications
zt = 0.8;
wn = 2; %[rad/s]->increasing this number will increase speed (decrease ts)
P = roots([1,2*zt*wn,wn^2]);

% place observer poles
L_trans = place(A',C',P);
L = L_trans';

% construct the overall system
sys_comb = ss([A-B*K, B*K;zeros(2,2),A-L*C],zeros(4,1),[C,0,0],D);

% simulate the system response to initial conditions
t_final = 5;
X0 = [-10;0;-5;0];
[y_comb,t_comb,x_comb] = initial(sys_comb,X0,t_final);

% plot the response
figure(1)
plot(t_full,y_full,'b','Linewidth',2)
hold on
plot(t_comb,y_comb,'r--','Linewidth',2)
xlabel('Time [s]')
ylabel('Theta [deg]')
legend('Full State','Combined')
legend('boxoff')
title('Full State and Observer Based Control')

