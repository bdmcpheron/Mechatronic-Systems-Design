%% ENGR 4020: Lecture 24 Full State Feedback
% MATLAB Handout
close all
clear all
clc

A = [0,1;16,0];
B = [0;1];
C = [1,0];

% check controllability
if rank(ctrb(A,B))==length(eig(A))
    disp('the system is controllable!')
end
% Note: this rank is 2, so controllable!

% desired closed loop pole locations
P = [-2+1i;-2-1i];

% place the poles where desired
K = place(A,B,P)  % no semicolon, I want to let this display to check by hand work

% construct the closed loop system
sys_full = ss(A-B*K,[0;0],C,0);

% check eignvalue (pole) locations
pole_loc = eig(A-B*K)

% simulate system response to initial conditions
t_final = 5;
X0 = [-10;0];
[y_full,t_full,x_full] = initial(sys_full,X0,t_final);

% plot the response
figure(1)
plot(t_full,y_full,'b','Linewidth',2)
xlabel('Time [s]')
ylabel('Theta [deg]')
title('Full State Feedback Control')

