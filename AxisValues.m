% Sophie SAKKA 
% Returns the points in the absolute frame to post axis (frame) lines
% Absolute frame in 0,0,0
% T: Position matrix


function [O xu yu zu] = AxisValues(T)
% Scaling the axis plot
s=0.1;

% 4 points needed to plot the frame:
% Transform vectors from f frame to 0 frame
O=T*[0  ;0  ;0  ;1];     % Origin of frame f
xu=T*[s*1;0  ;0  ;1];     % scaled unit vector in x
yu=T*[0  ;s*1;0  ;1];     % scaled unit vector in y
zu=T*[0  ;0  ;s*1;1];     % scaled unit vector in z