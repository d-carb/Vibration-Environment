%
% Generates complete model of the track
%

test_size = 300;
step_size = 0.001;
% tb = (sqrt(2*r*step_size))/v;
tb = zeros(1,size(speed_at_steps,2))

% % Testing
run_time = zeros(1,test_size);
run_disp = zeros(1,test_size);

% Full Arr 2x speed at steps
% run_time = zeros(1,2*size(speed_at_steps,2));
% run_disp = zeros(1,2*size(speed_at_steps,2));
prev_time = 0;
prev_disp = 0;

for i=1:test_size 
% for i=1:2*size(speed_at_steps,2)
    
    % set vals at time of impact
    if mod(i,2)==1
        run_time(i) = time_at_steps(i/2 + 0.5);
        run_disp(i) = prev_disp;
   
    % set vals at time of impact + delay
    else
        tb = (sqrt(2*r*step_size))/(speed_at_steps(i/2))
        run_time(i) = prev_time + tb;
        run_disp(i) = prev_disp + step_size;
    end
    
    prev_disp = run_disp(i);
    prev_time = run_time(i);
end

interpolate(run_time, run_disp);

% plot(run_time,run_disp,'o');
% xlabel('Time');
% ylabel('Displ');