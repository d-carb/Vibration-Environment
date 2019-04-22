% 21/02/19
% Daniel Carbonell
% HYPED, Technical Director
% Generator for complete model of the track given arbitrary parameters

parameters_pitch
%% Parameters from trajectory sim
speed_at_steps = csvread('speed_at_steps.csv');
time_at_steps = csvread('time_at_steps.csv');

%% Parameters for track and wheel
r = 0.04;
max_step = 0.00111;
min_step = 0.0005;
sample_size = 2*size(speed_at_steps,2);
step_size = (max_step-min_step).*rand(350,1)+min_step; % Random step between 0 & 1mm
A = [1,-1];
rand_neg = A(randi([1,2],1,sample_size));
track_filename = "track01.csv";
newtrack = 1; % If=1 make new track, else read from file

%% Initial values & blank arrays
tb = zeros(1,size(speed_at_steps,2));
run_time = zeros(1,sample_size);
run_disp = zeros(1,sample_size);
prev_time = 0;
prev_disp = 0;

% Uncomment to save new file
% tr01=[lin_t;lin_x;lin_v];
% csvwrite("track01.csv",tr01);



if newtrack == 1
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
            tb(i) = (sqrt(2*r*step_size(i/2)))/(speed_at_steps(i/2));
            run_time(i) = prev_time + tb(i);
            run_disp(i) = prev_disp + rand_neg(i/2)*step_size(i/2);

    %         run_speed(i) = speed_at_steps(i\2);
        end

        prev_disp = run_disp(i);
        prev_time = run_time(i);

    end

    % [lin_t, lin_x]=interpolate(run_time, run_disp);

    run_disp = [run_disp, 0];
    run_time = [run_time, run_time(end)+0.1];

    speed_at_steps = [0, speed_at_steps];
    time_at_steps = [0, time_at_steps];

    % Find accel for weight transfer
    accel = 0;
    for i=2:sample_size/2
    accel(i) = (speed_at_steps(i)-speed_at_steps(i-1))/(time_at_steps(i)-time_at_steps(i-1));
    end
    accel(2) = accel(3);
    accel = [accel, 0];

    wt_transfer = weight_shift(accel);
    wt_transfer = wt_transfer;

    [lin_t, lin_x, lin_v, lin_sft]=interpolate(run_time, run_disp, time_at_steps, speed_at_steps, wt_transfer);

    % [lin_t2, lin_v]=interpolate(time_at_steps, speed_at_steps);

    % step_delay = zeros(1,size(lin_v,2));

else
    % read values from file
    [lin_t, lin_x, lin_v] = split_array(csvread(track_filename));
    
    % Find accel for weight transfer
    accel = 0;
    for i=2:sample_size/2
    accel(i) = (speed_at_steps(i)-speed_at_steps(i-1))/(time_at_steps(i)-time_at_steps(i-1));
    end
%     accel = [accel, 0]
    
    wt_transfer = weight_shift(lin_a);

    
end

% Find nan values in velocity equations
minnanv = min(find(all(isnan(lin_v),1)));
% Find nan values in weight shift equations
minnanw = min(find(all(isnan(lin_sft),1)));

% Fix NaN issues
lin_v(isnan(lin_v))=lin_v(minnanv-1);
lin_sft(isnan(lin_sft))=lin_sft(minnanv-1);

step_delay=0;
for i = 1: size(lin_v,2)
    step_delay(i) = (l1 + l2)/lin_v(i);
end

step_delay(1) = 0;


%%
% initializing time and displacement vectors for SIMULINK model
disp_var.time = lin_t;
disp_var.signals.values = lin_x';
disp_var.signals.dimensions = 1;

% initializing time delay vectors for SIMULINK model
time_del.time = lin_t;
time_del.signals.values = step_delay';
time_del.signals.dimensions = 1;

% initializing front weight shift for SIMULINK model
weight_sh_f.time = lin_t;
weight_sh_f.signals.values = lin_sft';
weight_sh_f.signals.dimensions = 1;

% initializing rear weight shift for SIMULINK model
weight_sh_r.time = lin_t;
weight_sh_r.signals.values = 1.-lin_sft';
weight_sh_r.signals.dimensions = 1;


%% Data logging

fig = figure;
left_color = [0 .0 0];
right_color = [0 0 0];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);
% plot(t, x,'o',xq,vq,'-'); % with dots
ax = gca;
ax.FontSize = 16; 
set(gcf,'color','w');
plot(run_time, run_disp, lin_t, lin_x, 'Color','blue', 'linewidth', 2); % no dots
ax = gca;
ax.FontSize = 14; 
% yyaxis left;
ylabel('Vertical Displacement (m)', 'FontSize', 20,'Color','blue')
xlabel('Run Time (s)', 'FontSize', 20)
% 
% yyaxis right;
% 
% plot(lin_t, lin_v,'-','Color','red');
% ylabel('Run Speed (m/s)', 'FontSize', 20, 'Color','red')


% right_color = [0 .5 .5];
% set(figure,'defaultAxesColorOrder',['blue'; 'red']);

% plot(freq_rat,TR,'LineWidth',2)


% xlabel("Frequency Ratio", 'FontSize', 20);
% % xlabel("Damping Constant (Ns/m)")
% ylabel("Transmissibility Ratio", 'FontSize', 20);

% figure;
% plot(lin_t, lin_v, '-','LineWidth',2);
% ax = gca;
% ax.FontSize = 14; 
% set(gcf,'color','w');
% 
% yyaxis left;
% ylabel('Run Speed (m/s)', 'FontSize', 20,'Color','blue')
% xlabel('Run Time (s)', 'FontSize', 20)
% 
% yyaxis right;
% plot(lin_t, lin_sft, '-','LineWidth',2);
% 
% ylabel('Load on Front Wheel', 'FontSize', 20)



% legend('Samples','Linear Interpolation');