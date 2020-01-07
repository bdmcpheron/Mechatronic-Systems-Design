%% ENGR 4020 Lecture 34 Kalman filtering example
close all
clear all
clc

% plant dynamics
A = [1.1269 -0.494, 0.1129;
      1,    0,      0;
      0     1,      0];  
B = [-0.3832; 0.5919; 0.5191];
C = [1, 0, 0];

% discrete state space system
Plant = ss(A,[B B],C,0,-1,'inputname',{'u' 'w'},'outputname','y');

% assume the noise covariances are 1 for this example and design a kalman
% filter for steady state operation (constant filter gains)
Q = 1; 
R = 1;
[kalmf,L,P,M] = kalman(Plant,Q,R);
M % display the innovation gain M

% keep only the output estimate y
kalmf = kalmf(1,:);

% create the system from board example
a = A;
b = [B B 0*B];
c = [C;C];
d = [0 0 0;0 0 1];
P = ss(a,b,c,d,-1,'inputname',{'u' 'w' 'v'},'outputname',{'y' 'yv'});
sys = parallel(P,kalmf,1,1,[],[]);
SimModel = feedback(sys,1,4,2,1);   % Close loop around input #4 and output #2
SimModel = SimModel([1 3],[1 2 3]); % Delete yv from I/O list

% inputs and outputs are?
SimModel.InputName
SimModel.OutputName

% simulate the filter behavior
t = [0:100]';
u = sin(t/5);

n = length(t);
rng default
w = sqrt(Q)*randn(n,1);
v = sqrt(R)*randn(n,1);

[out,x] = lsim(SimModel,[w,v,u]);

y = out(:,1);   % true response
ye = out(:,2);  % filtered response
yv = y + v;     % measured response

figure(1)
subplot(211), plot(t,y,'--',t,ye,'-'), 
xlabel('No. of samples'), ylabel('Output')
title('Kalman filter response')
subplot(212), plot(t,y-yv,'-.',t,y-ye,'-'),
xlabel('No. of samples'), ylabel('Error')

% check the covariance errors
MeasErr = y-yv;
MeasErrCov = sum(MeasErr.*MeasErr)/length(MeasErr)

EstErr = y-ye;
EstErrCov = sum(EstErr.*EstErr)/length(EstErr)
% smaller than measured!

% instead of steady state, it is far more valuable to let filter parameters
% change with time (using recursion).  This is because most systems are not
% time invariant, but rather time carying

% Theory on board

% get noisy system
sys = ss(A,B,C,0,-1);
y = lsim(sys,u+w);      
yv = y + v;

% implement time varying filter
P = B*Q*B';         % Initial error covariance
x = zeros(3,1);     % Initial condition on the state
ye = zeros(length(t),1);
ycov = zeros(length(t),1); 

for i = 1:length(t)
  % Measurement update
  Mn = P*C'/(C*P*C'+R);
  x = x + Mn*(yv(i)-C*x);   % x[n|n]
  P = (eye(3)-Mn*C)*P;      % P[n|n]

  ye(i) = C*x;
  errcov(i) = C*P*C';

  % Time update
  x = A*x + B*u(i);        % x[n+1|n]
  P = A*P*A' + B*Q*B';     % P[n+1|n]
end

% compare graphically 
figure(2)
subplot(211), plot(t,y,'--',t,ye,'-')
title('Time-varying Kalman filter response')
xlabel('No. of samples'), ylabel('Output')
subplot(212), plot(t,y-yv,'-.',t,y-ye,'-')
xlabel('No. of samples'), ylabel('Output')

% look to see if filter reaches steady state on error covariance
figure(3)
subplot(211)
plot(t,errcov), ylabel('Error covar')
subplot(212), plot(t,y-yv,'-.',t,y-ye,'-')
xlabel('No. of samples'), ylabel('Output')

% check error covariance
EstErr = y - ye;
EstErrCov = sum(EstErr.*EstErr)/length(EstErr)

% notice that the final value of M from this procedure and M from steady
% state coincide
Mn
M