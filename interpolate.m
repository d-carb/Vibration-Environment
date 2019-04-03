% 21/02/19
% Daniel Carbonell
% HYPED, Technical Director
% Interpolate the values in time given initial and end conditions. 

% function [tq, xq] = interpolate(t, x)
% 
% %t(end);
% 
% % Interpolated time resolution
% tq = (0:0.0001:t(end));
% 
% % Interpolated displacement value
% xq = interpn(t, x,tq,'linear');
% 
% % vq=0;
% % vq = interpn(t, v,tq,'linear');
% % figure
% % % plot(t, x,'o',xq,vq,'-'); % dot
% % plot(t, x,tq,xq,'-'); % no dot
% % % plot(xq, vq)
% % legend('Samples','Linear Interpolation');
% 
% end

function [tq, xq, vq] = interpolate(t, x, ts, vs)

%t(end);

% Interpolated time resolution
tq = (0:0.00001:t(end));

% Interpolated displacement value
xq = interpn(t, x,tq,'linear');
vq = interpn(ts, vs,tq,'linear');


% vq=0;
% vq = interpn(t, v,tq,'linear');
% figure
% % plot(t, x,'o',xq,vq,'-'); % dot
% plot(t, x,tq,xq,'-'); % no dot
% % plot(xq, vq)
% legend('Samples','Linear Interpolation');

end