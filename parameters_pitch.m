%08/02/2019
%Arturas Jocas
%HYPED, Head of Simulations Team
%Parameters for suspension model using SIMULINK

%% Clear all 
clear;

%% General Parameters
%Spring constants 
k = 70000; %(N/m), spring constant for suspension system
k1 = k;
k2 = k;

c = 100; %(Ns/m), damping coefficient for suspension system
c1 = c;
c2 = c;

%Masses of the wheels and pod (kg)
m_wheel = 0.25; % mass of one suspension wheel 
m_pod = 305; %mass of just pod and internals 

%Moments of inertia
Iyy = 115; %% about pitch (theta) axis 

%Distances from the front/back the pod to the CoM 
L_front = 0.62;
l1 = L_front;
L_back = 0.63;
l2 = L_back;

%Arbitrary displacement (bump)
x = 0.001;
step_size = 0.001;

%Constants
g = 9.81; 

%Wheel radius
r = 0.04;

%Velocity (m/s)
v = 10;
%% Parameters from trajectory sim
speed_at_steps = csvread('speed_at_steps.csv');
time_at_steps = csvread('time_at_steps.csv');
rand_step = (0.001).*rand(350,1);

%% x-displacement of CoM of wheel over time
a = sqrt(x*(2*r-x));

% Direction of step (1 = up, -1 = down)
step_dir = -1;

tb = (sqrt(2*r*step_size))/v;

% plot(time_at_steps,speed_at_steps)

%% Symbolic Expressions
% syms t;
% x_positive = step_dir*(x/tb * t * heaviside(tb - t) + x * heaviside(t - tb));
% x_negative = 0;
% x_total = piecewise(t > 0, x_positive, t <= 0, x_negative);
% fplot(x_total, [-0.0015 0.0015]);
% ylim([-0.0015 0.0015]);
% ylim([-x 1.5*x]);
% 
% title('Trajectory of the Wheel Centre at 80m/s');
% xlabel('Time (s)');
% ylabel('Displacement (m)');
% set(gca,'FontSize',14)
