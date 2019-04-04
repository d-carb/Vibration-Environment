% 27/03/19
% Daniel Carbonell
% HYPED, Technical Director
% Splits array in 2, used when reading track data from csv

function [s1,s2,s3] = split_array(x)
    lx = (length(x));
    third = lx/3;
    twothird = 2*lx/3;
%     half = ceil(lx/2);
    % Separate bu 1/2 then take the transpose to align the matrix
    s1 = x(1:third)';
    s2 = x(third+1:twothird)';
    s3 = x(twothird+1:end)';
end