% Sophie SAKKA 

% Animate body parts defined by the 6dj dataset (20 joint frames) and the
% 6d dataset (17 segment frames)
%
% Plot energies in real time on subplots on the right (Kinetic, Potential)
%
% Calculate Velocities, Accelerations, Momenta and Forces to be plotted by
% PlotResults.
%
% Load .mat file saved with function openfile which contains the
% transformation matrices already interpolated and filtered.
%
% Manually input limb dimensions and inertia matrices.
%
% Change figure properties for 3D model under Axes Settings.
%
% Save avi video by uncommenting the last line.

clear
%clc

load MediumJump.mat
pathname = 'animations/';  

figure(191)
clf
subplot(1,2,1)
hold on
% Axes settings
xlabel('x','FontSize',14);
ylabel('y','FontSize',14);
zlabel('z','FontSize',14);
set(gca,'FontSize',14);
axis vis3d equal;
view([180,20]);
camlight LEFT;
%grid on;
axis off
xlim([-1,1]);
ylim([-0.5,0.5]);
zlim([0,3]);

Transparency = 1;
GenerateBodyHandlers



CalculateDynamics
%%%%%%%%%%%%%%%%%%%%%%%%%% KINETIC ENERGY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,2)
hold on
axis([0 samples/60 0 20])
set(gca,'Color',[0.8 0.8 0.8])
xlabel('t(s)')
ylabel('Kinetic Energy (J)')

GenerateKineticEnergyHandlers

%%%%%%%%%%%%%%%%%%%%%%%%%% POTENTIAL ENERGY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,4)
hold on
axis([0 samples/60 0 200])
set(gca,'Color',[0.8 0.8 0.8])
xlabel('t(s)')
ylabel('Potential Energy (J)')

GeneratePotentialEnergyHandlers

%%
% ANIMATION
for i=1:samples
    
    UpdateBodyHandlers
    
    UpdateKineticEnergyHandlers
    
    UpdatePotentialEnergyHandlers
   
    drawnow;
    F(i) = getframe(gcf); % save frames for video
    pause(0.02)
end
%%
% Save as AVI
%movie2avi(F,strcat(pathname,filename,'_body_60fps.avi'),'fps',60);