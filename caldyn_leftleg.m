function [] = caldyn_leftleg()
    %
    % Function to compute the forces and moments of each link in the human
    % body by modelling such that the entire human body is a tree structure
    % robot with the left foot acting as the base of the robot.
    %
    % This function would be suitable for calculating the dynamics for the
    % following scenarios : 
    %   1) motion of a single leg (right) with no arm movements
    %   2) motion of a single leg (right) with arm movements
    %
    
    % sampling time
    dt = 1/60;  % 60 Hz
    
    % number of segments
    nseg = 16;
    
    % variables to hold string terms that will be concatenated to form
    % variable names
    seg16 = {'Head', ...
             'LeftHand', 'LowerArmL', 'UpperArmL', ...
             'RightHand', 'LowerArmR', 'UpperArmR', ...
             'UpperLegR', 'LowerLegR', 'FootR', ...
             'UpperTrunk', 'MiddleTrunk', 'LowerTrunk', ...
             'UpperLegL', 'LowerLegL', 'FootL'};
         
    for j = 1:nseg        
        % get base workspace variables into function workspace
        % T = T<seg16{j}>
        T = evalin('base', sprintf('T%s;', seg16{j}));
       
        % compute the 6x1 screw representation of link positions from
        % transformation matrices
        % X_<seg16{j}> = pose(T<seg16{j}>)
        eval(sprintf('X_%s = pose(T);', seg16{j}));
        
        % compute velocity and acceleration
        % [Xdot_<seg16{j}>, Xddot_<seg16{j}>] = vel_acc(X_<seg16{j}>, dt)
        eval(sprintf('[Xdot_%s, Xddot_%s] = vel_acc(X_%s, dt);', ...
                     seg16{j}, seg16{j}, seg16{j}));
    end
    
    % TESTED TILL HERE
    
end

