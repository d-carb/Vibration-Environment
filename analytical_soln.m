% 07/03/19
% Daniel Carbonell
% HYPED, Technical Director
% Analytical solution of suspension model

parameters_pitch

% Determinant found with AD-BC of array elems, conv will help find them

% A and D elements of the arrays
a = [m_pod c1+c2 k1+k2];
d = [Iyy (c2*l2^2+c1*l1^2) (k2*l2^2+k1*l1^2)];
ad = conv(a,d)

% B and C elements of the arrays
b = [0 l1*c2-l1*c1 k2*l2+k1*l1];
c = [0 l2*c2-l1*c1 k2*l2-k1*l1];
bc = conv(b,c)

% Find determinant and roots
deter = ad - bc;
disp('Roots: ')
r = roots(deter)

% Find undamped natural freq and damping ratio
disp('Natural Frequencies: ')
for i = 1: size(r,1)
    wn(i) = sqrt(imag(r(i))^2 + real(r(i))^2);
end

wn

