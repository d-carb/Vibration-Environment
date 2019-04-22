% 07/03/19
% Daniel Carbonell
% HYPED, Technical Director
% Analytical solution of suspension model

clear
parameters_pitch

paramRes = 10001;
c_arr = linspace(0,100,paramRes);
k_arr = linspace(100,500000,paramRes);

% [X,Y] = meshgrid(k_arr,c_arr);
% k1 = 70000;
% k2=k1;
% c1 = 100;
% c2 = c1;
m_pod = 300;

j=paramRes;

% Let's get loopy
% for j=1:paramRes
    % Determinant found with AD-BC of array elems, conv will help find them
    
%     j;
%     k1 = k_arr(j);
%     k2=k1;
%     
%    
%     c1 = c_arr(j);
%     c2 = c1;
    
%     k1 = k_arr(j);
    k1 = 150000%k_arr(j);
    k2=k1;
    c1 = 100;%c_arr(j);
    c2 = c1;
%     
    
    % A and D elements of the arrays
    a = [m_pod c1+c2 k1+k2];
    d = [Iyy (c2*l2^2+c1*l1^2) (k2*l2^2+k1*l1^2)];
    ad = conv(a,d);

    % B and C elements of the arrays
    b = [0 l1*c2-l1*c1 k2*l2+k1*l1];
    c = [0 l2*c2-l1*c1 k2*l2-k1*l1];
    bc = conv(b,c);

    % Find determinant and roots
    deter = ad - bc;
%     disp('Roots: ')
    r = roots(deter);

    % Find undamped natural freq and damping ratio
%     disp('Natural Frequencies: ')
    for i = 1: size(r,1)
        wn(i) = sqrt(imag(r(i))^2 + real(r(i))^2);
    end

    wn;
    
    nat_freq(j,1) = wn(1);
    nat_freq(j,2) = wn(3);
    nat_freq;
    
    damp_freq(j,1) = imag(r(1));
    damp_freq(j,2) = imag(r(3));
    damp_freq;

    damp_rat(j,1) = -real(r(1))/nat_freq(j,1);
    damp_rat(j,2) = -real(r(3))/nat_freq(j,2);
    damp_rat;
    
%     freq_rat(j,1) = 
% end

force_freq(:,1) = linspace(0,70,paramRes);
% force_freq(:,1) = linspace(0,144,paramRes);

% freq_rat = force_freq./nat_freq;
freq_rat = force_freq./nat_freq(j,:);

freq_rat_sq = freq_rat.^2;
damp_rat_sq = damp_rat(j,:).^2;

TR = sqrt((1+4*damp_rat_sq.*freq_rat_sq)./((1-freq_rat_sq).^2 + 4*damp_rat_sq.*freq_rat_sq));

disp("finished");

figure;

%% Transmissibility ratio
plot(freq_rat,TR,'LineWidth',2)
ax = gca;
ax.FontSize = 14; 
set(gcf,'color','w');
xlabel("Frequency Ratio", 'FontSize', 20);
% xlabel("Damping Constant (Ns/m)")
ylabel("Transmissibility Ratio", 'FontSize', 20);


%% Varying frequency 
% plot(k_arr,nat_freq,'LineWidth',2)%,k_arr,damp_freq)
% ax = gca;
% ax.FontSize = 14; 
% set(gcf,'color','w');
% xlabel("Spring Constant (N/m)", 'FontSize', 20);
% % xlabel("Damping Constant (Ns/m)")
% ylabel("Natural Frequency (rad/s)", 'FontSize', 20);
% % yline(144)
% yline(72,'-','1/2 Speed',  'FontSize', 16);
% yline(36,'-','1/4 Speed',  'FontSize', 16);
% yline(18, '-', '1/8 Speed',  'FontSize', 16);




% yyaxis left;
% ylabel('Vertical Displacement (m)', 'FontSize', 20,'Color','blue')
% xlabel('Run Time (s)', 'FontSize', 20)

% yyaxis right;
% % plot(lin_t, lin_v,'-');
% ylabel('Run Speed (m/s)', 'FontSize', 20)
% yline(23)

% 
% plot(run_time, run_disp, lin_t, lin_x, 'Color','blue'); % no dots
% yyaxis left;
% ylabel('Vertical Displacement (m)', 'FontSize', 20,'Color','blue')
% xlabel('Run Time (s)', 'FontSize', 20)
% 
% yyaxis right;
% plot(lin_t, lin_v,'-');
% ylabel('Run Speed (m/s)', 'FontSize', 20)

% legend("Nat freq","Damp Nat freq")