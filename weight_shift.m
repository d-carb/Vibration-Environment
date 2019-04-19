% 04/04/19
% Daniel Carbonell
% HYPED, Technical Director
% Weight shift, returns an array of ratio of weigth on the front wheels
% during a run

% syms r1 r2 l1 l2 h w m g a

% parameters_pitch

% m = 275;
% g = 9.81;
% a = -2.2*g;
% L_back = 0.63;
% L_front = 0.62;
% h = 0.03;
% w = m_pod*g;

function [shft] = weight_shift(acc_arr)
parameters_pitch
h = 0.03;
w = m_pod*g;
%t(end);

% % Interpolated time resolution
% tq = (0:0.001:t(end));
% 
% % Interpolated displacement value
% xq = interpn(t, x,tq,'linear');
% vq = interpn(ts, vs,tq,'linear');
% aq = interpn(ts, as, tq, 'linear');

for ia=1: length(acc_arr)
    r1 = (m_pod*g*l2-m_pod*acc_arr(ia)*h)/(L_back+L_front);
    r2 = (m_pod*g*l2+m_pod*acc_arr(ia)*h)/(L_back+L_front);
    w_tot = r1+r2;
    shft(ia) = r1/w_tot;
end
% vq=0;
% vq = interpn(t, v,tq,'linear');
% figure
% % plot(t, x,'o',xq,vq,'-'); % dot
% plot(t, x,tq,xq,'-'); % no dot
% % plot(xq, vq)
% legend('Samples','Linear Interpolation');

end
% 
% r1 = (m*g*l2-m*a*h)/(l1+l2)
% r2 = (m*g*l2+m*a*h)/(l1+l2)
% w_tot = r1+r2;
% f_load = 100*r1/w_tot
