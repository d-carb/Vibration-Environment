%
% The aim of this script is to interpolate the values in time given
% initial and end conditions. This will convert discrete points
% into a funtion into a continous fucntion to a specified resolution
%

function out = interpolate(t, x)

% % vertical height at steps before and after
% x = [1 2 2 1 1 3 3];
% 
% % time at steps impact and after peaking
% t = [1 3 4 6 8 10 12];

% Interpolation time resolution
xq = (0:0.0001:t(end));

% interpolates
vq = interpn(t, x,xq,'linear');

figure
plot(t, x,'o',xq,vq,'-');
% plot(xq, vq)
legend('Samples','Linear Interpolation');

end