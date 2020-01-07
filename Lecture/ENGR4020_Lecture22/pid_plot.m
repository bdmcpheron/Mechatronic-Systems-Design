function [po, y, t] = pid_plot(num,den,Kp,Ki,Kd)
% Inputs: num,den,Kp,Ki,Kd
% Outputs: percent overshoot, y and t

% start by defining the PID compensator
numc = [Kd, Kp, Ki];
denc = [0, 1, 0];
% combine the compensator and the plant in series
numcg = conv(num,numc);
dencg = conv(den,denc);
% close the loop
Gfb = feedback(tf(numcg,dencg),1);
[y,t] = step(Gfb);
% start a figure and clear it
figure (1)
clf
% plot the step response
plot(t,y,'r','linewidth',3);
hold on
% plot the 2% settling lines
yss = dcgain(Gfb);
plot(t,1.02*yss*ones(size(t)),'--k','linewidth',2);
plot(t,0.98*yss*ones(size(t)),'--k','linewidth',2);
xlabel('Time [s]')
ylabel('Magnitude')

grid on
% calculate the percent overshoot
po = 100*(max(y)-yss)/yss;