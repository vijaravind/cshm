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
    left_foot = -F{11};
    
    % plot z forces
    figure(1); hold on;
    plot(fpFz, 'b'); hold on;
    plot(left_foot(3,:), 'g');
    
end

