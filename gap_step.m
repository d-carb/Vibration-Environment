% 01/04/19
% Daniel Carbonell
% HYPED, Technical Director
% Generates points for gapped step track

%% EVEN - CONFRIMED

% syms a u r
% 
% S = (a^2)/4 + u*(u-2*r) == 0;
% 
% soln = solve(S, u)
% 
% a = 0.003;
% r = 0.04;
% 
% newsol = subs(soln);
% fprintf("First val %d \n", double(newsol(1)))
% fprintf("Second val %d \n", double(newsol(2)))

%% UNEVEN

syms ut u1 u2 at a1 a2 r

% S = [r^2 == a1^2 + (r-u1)^2; r^2 == a2^2 + (r-u2)^2; u2 == ut + u1; at == a1 + a2]

S = [at == sqrt((u2-ut)*(2*r-u2+ut))+sqrt(u2*(2*r-u2))];

soln = solve(S,u2)

ut = 0.001;
at = 0.003;
r = 0.04;


newsol = subs(soln);
fprintf("First val %d \n", double(newsol(1)))
fprintf("Second val %d \n", double(newsol(2)))

% syms c r z b
% 
% S = sqrt((c-b)*(2*r-c+b)) + sqrt(c*(2*r-c)) == z
% 
% soln = solve(S,c)
% 
% r = 0.04;
% % total gap
% z = 0.003;
% % % first gap
% % x;
% % % second gap
% % y;
% % total step
% b = 0.001;
% % % first step
% % a;
% % % second step
% % b;
% 
% % S = sqrt((c-b)*(2*r-c+b)) + sqrt(c*(2*r-c)) == z
% 
% newsol = subs(soln);
% fprintf("First val %d \n", double(newsol(1)))
% fprintf("Second val %d \n", double(newsol(2)))