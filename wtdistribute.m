function [ratio_l, ratio_r] = wtdistribute(x_com, X_FootL, X_FootR)
%UNTITLED3 Summary of this function goes here
% author : Tilman
% input:
%   x_com: rowvector with center of x position of center of mass for each
%   time step
%
%@output:
% [ratio_l, ratio_r]
% 
    x_l_foot(1,:) = X_FootL(1,:);
    x_r_foot(1,:) = X_FootR(1,:);
    for i=1:length(x_com)
        % ratio - right
        ratio_r(i) = (x_com(i) - x_l_foot(i)) / (x_r_foot(i)-x_l_foot(i));
        % ratio - left
        ratio_l(i) = 1 - ratio_r(i);
    end
end

