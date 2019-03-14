% 21/02/19
% Daniel Carbonell
% HYPED, Technical Director
% Generator for complete model of the track given arbitrary parameters

%% Parameters from trajectory sim
speed_at_steps = csvread('speed_at_steps.csv');
time_at_steps = csvread('time_at_steps.csv');

%% Parameters for track and wheel
r = 0.04;
max_step = 0.00111;
min_step = 0.00001
sample_size = 2*size(speed_at_steps,2);
step_size = (max_step-min_step).*rand(350,1)+min_step; % Random step between 0 & 1mm
A = [1,-1];
rand_neg = A(randi([1,2],1,sample_size));

%% Initial values & blank arrays
tb = zeros(1,size(speed_at_steps,2));
run_time = zeros(1,sample_size);
run_disp = zeros(1,sample_size);
prev_time = 0;
prev_disp = 0;

%% Main loop
for i=2:sample_size 
    
    % set values at time of impact
    if mod(i,2)==1
%         i/2+0.5;
        run_time(i) = time_at_steps(i/2 + 0.5);
        run_disp(i) = prev_disp;
%         run_speed(i) = (run_speed(i-1)+speed_at_steps(i/2 + 0.5))/2;
   
    % set values at time of impact + rise time delay
    else
%         i/2
        tb = (sqrt(2*r*step_size(i/2)))/(speed_at_steps(i/2));
        run_time(i) = prev_time + tb;
        run_disp(i) = prev_disp + rand_neg(i/2)*step_size(i/2);
        
%         run_speed(i) = speed_at_steps(i\2);
    end
    
    prev_disp = run_disp(i);
    prev_time = run_time(i);

end

% [lin_t, lin_x]=interpolate(run_time, run_disp);

[lin_t, lin_x, lin_v]=interpolate(run_time, run_disp, time_at_steps, speed_at_steps);

% [lin_t2, lin_v]=interpolate(time_at_steps, speed_at_steps);


% initializing time and displacement vectors for SIMULINK model
var.time = lin_t;
var.signals.values = lin_x';
var.signals.dimensions = 1;

%% Data logging

% figure
% plot(t, x,'o',xq,vq,'-'); % with dots
plot(run_time, run_disp, lin_t, lin_x); % no dots
yyaxis left;
ylabel('Vertical Displacement (m)')
xlabel('Run Time (s)')

yyaxis right;
plot(lin_t, lin_v,'-');
ylabel('Run Speed (m/s)')

legend('Samples','Linear Interpolation');