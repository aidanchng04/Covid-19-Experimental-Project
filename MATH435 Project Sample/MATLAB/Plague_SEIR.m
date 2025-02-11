function HW2_Plague_SEIR
clear all
close all
clc

%% Input parameters

% input the transmission rat
% e and the recovery rate from your calculation
beta = 0.01;
eta = 1/5;
gamma = 1/4;
alpha = 1/10;
Pa = 1/3;
S0 = 90; % initial value of S
I0 = 10; % initial value of I
E0 = 0; % initial value of E
A0 = 0; %initial value of A
R0 = 0; %initial value of R
T0 = 0; % initial time t = 0
T = 100; % maximum time for the simulation

%% Define the ODEs

    % define the SEIR model
    % t: time
    % y: a vector for the dependent variables S(t), E(t) and I(t)
    % dy: the right hand side of the SIR model
    function dy = SEIR(t,y,beta,eta,gamma,alpha)
        dy = zeros(5,1); % store the derivatives
        dy(1) = - beta * y(1) * (y(3) + y(4)); % S term
        dy(2) = beta * y(1) * (y(3) + y(4)) - eta * (Pa) * y(2) - eta * (1 - Pa) * y(2); % E term
        dy(3) = eta * (1 - Pa) * y(2) - gamma * y(3); % I term
        dy(4) = eta * (Pa) * y(2) - alpha * y(4); % A term
        dy(5) = gamma * y(3) + alpha * y(4); % R term
    end

% Use Matlab built-in function ode45 to calculate the solutions
% The first input term "@(t,y)(SEIR(t,y,beta,eta,gamma))" give the name of the
% function where the ODE stores.
% The second input term "[T0 T]" gives the initial time and end time.
% The third input term "[S0; E0; I0]" give the initial values.
[sim_t, sim_y] = ode45(@(t,y)(SEIR(t,y,beta,eta,gamma,alpha)),[T0 T],[S0; E0; I0; A0; R0]);
% The results stores the time points in "sim_t" and 
% the values of S(t), E(t) and I(t) in the 1st, 2nd and 3rd columns of "sim_y".
sim_S = sim_y(:,1);
sim_E = sim_y(:,2);
sim_I = sim_y(:,3);
sim_A = sim_y(:,4);
sim_R = sim_y(:,5);

% plot the data and the simulation results
figure; hold on;
% then plot the simulation results
plot(sim_t, sim_S, 'linewidth',2);
plot(sim_t, sim_E, 'linewidth',2);
plot(sim_t, sim_I, 'linewidth',2);
plot(sim_t,sim_A, 'linewidth',2);
plot(sim_t,sim_R, 'linewidth',2);
legend({'simulation S(t)','simulation E(t)','simulation I(t)','simulation A(t)','simulation R(t)'},'FontSize',12)
xlabel('Time','FontSize',12);
ylabel('People','FontSize',12);
title('SEAIR Model');
end