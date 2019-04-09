% 04/04/19
% Daniel Carbonell
% HYPED, Technical Director
% Weight shift

% syms r1 r2 l1 l2 h w m g a

% parameters_pitch

m = 275;
g = 9.81;
a = -2.2*g;
l1 = 0.63;
l2= 0.62;
h = 0.03;
w = m*g;


r1 = (m*g*l2-m*a*h)/(l1+l2)
r2 = (m*g*l2+m*a*h)/(l1+l2)
w_tot = r1+r2;
f_load = 100*r1/w_tot
