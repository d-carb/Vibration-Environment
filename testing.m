% M = time_at_steps(1:end-17)
% csvwrite("time_at_steps.csv",M);

% 
% speed_at_steps=interp(speed_at_steps,2)

clear all; clc;

syms a u r

S = a == sqrt(u*(2*r-u))

soln = solve(S,r)

a = 0.003;
u = 0.001;

newsol = subs(soln(1))

double(newsol(1))