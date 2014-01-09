function [] = plot_forces_moments(F, M, filename)
    
    % read and store force plate readings
    filename = strcat(filename, '.csv');
    force_plate = csvread(filename, 2, 1);
    fpFx = force_plate(:, 3);
    fpFy = force_plate(:, 4);
    fpFz = force_plate(:, 5);
    fpMx = force_plate(:, 6);
    fpMy = force_plate(:, 7);
    fpMz = force_plate(:, 8);
    
    % store left foot calculations
    foot_l_f = F{11};
    foot_l_m = M{11};
     
    % plot x forces
    figure(1); hold on;
    subplot(2,1,1); plot(fpFx, 'b'); title('force plate Fx'); hold on;
    subplot(2,1,2); plot(foot_l_f(1,:), 'g'); title('calculated');
    
    % plot y forces
    figure(2); hold on;
    subplot(2,1,1); plot(fpFy, 'b'); title('force plate Fy'); hold on;
    subplot(2,1,2); plot(foot_l_f(2,:), 'g'); title('calculated');
    
    % plot z forces
    figure(3); hold on;
    subplot(2,1,1); plot(fpFz, 'b'); title('force plate Fz'); hold on;
    subplot(2,1,2); plot(-foot_l_f(3,:), 'g'); title('calculated');
    
    % plot x moments
    figure(4); hold on;
    subplot(2,1,1); plot(fpMx, 'b'); title('force plate Mx'); hold on;
    subplot(2,1,2); plot(foot_l_m(1,:), 'g'); title('calculated');
    
    % plot y moments
    figure(5); hold on;
    subplot(2,1,1); plot(fpMy, 'b'); title('force plate My'); hold on;
    subplot(2,1,2); plot(foot_l_m(2,:), 'g'); title('calculated');
    
    % plot z moments
    figure(6); hold on;
    subplot(2,1,1); plot(fpMz, 'b'); title('force plate Mz'); hold on;
    subplot(2,1,2); plot(foot_l_m(3,:), 'g'); title('calculated');
    
end

