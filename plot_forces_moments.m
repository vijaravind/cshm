function [] = plot_forces_moments(F, M, filename, double)
    
    % read and store force plate readings
    filename = strcat(filename, '.csv');
    force_plate = csvread(filename, 1, 1);
    fpT  = force_plate(:, 1);
    fpFx = force_plate(:, 2);
    fpFy = force_plate(:, 3);
    fpFz = force_plate(:, 4);
    fpMx = force_plate(:, 5);
    fpMy = force_plate(:, 6);
    fpMz = force_plate(:, 7);
     
    % store left/right foot calculations
    if double
        foot_f = F{8} + F{11};
        foot_m = M{8} + M{11};
    else
        foot_f = F{11};
        foot_m = M{11};
    end
    
    % time scaling
    samplefreq = 60;
    calcT = [0:size(foot_f,2)-1] / samplefreq;
     
    % plot x forces
    figure(1); hold on;
    subplot(2,1,1); plot(fpT, fpFx, 'b'); title('force plate Fx'); hold on;
    subplot(2,1,2); plot(calcT, foot_f(1,:), 'g'); title('calculated');
    
    % plot y forces
    figure(2); hold on;
    subplot(2,1,1); plot(fpT, fpFy, 'b'); title('force plate Fy'); hold on;
    subplot(2,1,2); plot(calcT, foot_f(2,:), 'g'); title('calculated');
    
    % plot z forces
    figure(3); hold on;
    subplot(2,1,1); plot(fpT, fpFz, 'b'); title('force plate Fz'); hold on;
    subplot(2,1,2); plot(calcT, -foot_f(3,:), 'g'); title('calculated');
    
    % plot x moments
    figure(4); hold on;
    subplot(2,1,1); plot(fpT, fpMx, 'b'); title('force plate Mx'); hold on;
    subplot(2,1,2); plot(calcT, foot_m(1,:), 'g'); title('calculated');
    
    % plot y moments
    figure(5); hold on;
    subplot(2,1,1); plot(fpT, fpMy, 'b'); title('force plate My'); hold on;
    subplot(2,1,2); plot(calcT, foot_m(2,:), 'g'); title('calculated');
    
    % plot z moments
    figure(6); hold on;
    subplot(2,1,1); plot(fpT, fpMz, 'b'); title('force plate Mz'); hold on;
    subplot(2,1,2); plot(calcT, foot_m(3,:), 'g'); title('calculated');
    
end

