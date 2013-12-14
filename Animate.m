% Sophie SAKKA 
% Animate:
% -- 20 joint frames: origin white, axis magenta/yellow/cian
% -- 17 segment frames: origin blue, axis red/gree/blue
% -- Skeleton: black lines connecting 20 joint frames
% -- 16 body parts
% -- 16 frames which define the body parts
% Load .mat file saved with function openfile.
% Save avi video by default, disable by commenting the last line.

clear
%clc

load MediumJump.mat
pathname = 'animations/';

figure(651)
clf
hold on
% Axes settings
xlabel('x','FontSize',14);
ylabel('y','FontSize',14);
zlabel('z','FontSize',14);
set(gca,'FontSize',14);
axis vis3d equal;
view([180,20]);
camlight LEFT;
axis off
xlim([-1,1]);
ylim([-0.5,0.5]);
zlim([0,3]);

ShowJointFrames = [false true]; % [Origin markers, xyz Axes]
ShowTrackedFrames = [false true]; % [Origin markers, xyz Axes]
GenerateTrackedFrameHandlers

Transparency = 0.2;
GenerateBodyHandlers


for i=1:samples
    UpdateTrackedFrameHandlers
    UpdateBodyHandlers
    
    drawnow;
    F(i) = getframe(gcf); % save frames for video
    %pause(1)
end

% Save as AVI
%movie2avi(F,strcat(pathname,filename,'_skeleton_60fps.avi'),'fps',60);