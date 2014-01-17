function [pos_com, M] = uppercom(Masses, X)
%UNTITLED2 Summary of this function goes here
% author : Tilman
%   Input:  X is a 3d Matrix containing x,y,z of all sements for each time step t (size: [3,t,n])
%           (x_1,x_2,...,x_n; y_1, y_2,...,y_n, z_1, z_2,...z_n)
%           Masses: rowvector containing the mass of each segement (sieze:
%           [1,n]            
%   Output: - 2D Matrix caintaining the center of mach for each time step
%   (size: [3,t])
%           -M: summed mass of all segments
%   Reference: http://en.wikipedia.org/wiki/Center_of_mass#A_system_of_particles

    Masses = Masses(:);

    %init pos_com
    pos_com = zeros(3, size(X,2));

    % total mass
    M = sum(Masses);

    for i = 1:size(X,2)
        % x,y,z possition coordinates at one time step
        r = reshape(X(1:3,i,:), 3, size(X,3));
        % init. temp varialbe
        tmp = zeros(3,1);
        for j = 1:size(r,2)
            tmp = tmp + Masses(j)*r(1:3,j);     % sum up
        end
        % calculate the position of the center of mass
        pos_com(1:3,i) = (1/M) * tmp;
    end
    
end
