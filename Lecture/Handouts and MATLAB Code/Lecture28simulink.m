%%Lecture 28 Simulink

% Repeat the same exercise in Simulink so it looks more like what we are
% used to (block diagram model
A = [ 0   1   0
     980  0  -2.8
      0   0  -100 ];

B = [ 0
      0
      100 ];

C = [ 1 0 0 ];

% poles for placement
p1 = -20 + 20i;
p2 = -20 - 20i;
p3 = -100;

% place the poles
K = place(A,B,[p1 p2 p3]);

% break out individual poles
K1 = K(1);
K2 = K(2);
K3 = K(3);

%calculate Nbar
sys_cl = ss(A-B*K,B,C,0);
Nbar = rscale(sys,K);

% simulate the simulink file
sim('Lecture28sim.slx')