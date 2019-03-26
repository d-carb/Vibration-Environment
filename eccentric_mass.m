% 20/03/19
% Daniel Carbonell
% HYPED, Technical Director
% Model of ERM used to reporuduce the vibration environment
clear all

%% Global Parameters
% All values in kg, m, rad/s

pod_mass = 300;
mount_mass = 20;
ecc_mass = 1.2;
sys_mass = 170;
sys_mass = pod_mass+mount_mass+ecc_mass
ecc_dist = 0.04;
sprg_const = 1000;
damp_const = 1000;
rot_freq = 144;
sys_freq = sqrt(sprg_const/sys_mass)
freq_ratio = rot_freq/sys_freq
damp_ratio = damp_const/(2*sys_mass*sys_freq)
fre_hz = rad_hertz(sys_freq)

%% Transmitted force

comm_ratio = 2*damp_ratio*freq_ratio; % Commonly used expression

TR = sqrt((1+comm_ratio^2)/(1-freq_ratio^2)^2 + comm_ratio^2);
trans_force = ecc_mass*ecc_dist*rot_freq^2*TR

time_arr = linspace(0, 0.2, 700200);

force_time = trans_force*sin(time_arr.*rot_freq);

plot(time_arr, force_time)