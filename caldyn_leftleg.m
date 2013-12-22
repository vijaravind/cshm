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
    
    % variables to hold string terms that will be concatenated to form
    % variable names
    [seg16, nseg] = segments();
         
    for j = 1:nseg 
        seg = seg16{j};
        % get base workspace variables into function workspace
        % T = T<seg16{j}>
        T = evalin('base', sprintf('T%s;', seg));
       
        % compute the 6x1 screw representation of link positions from
        % transformation matrices
        % X_<seg16{j}> = pose(T<seg16{j}>)
        eval(sprintf('X_%s = pose(T);', seg));
        
        % compute velocity and acceleration
        % [Xdot_<seg16{j}>, Xddot_<seg16{j}>] = vel_acc(X_<seg16{j}>, dt)
        eval(sprintf('[Xdot_%s, Xddot_%s] = vel_acc(X_%s, dt);', ...
                     seg, seg, seg));
    end
    
    % TESTED TILL HERE
    
end

