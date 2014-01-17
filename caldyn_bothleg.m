function [F, M] = caldyn_bothleg(mass, Ig, CoG)
    % [F, M] = caldyn_bothleg(mass, Ig, CoG)
    %
    % Function to compute the forces and moments of each link in the human
    % body by modelling such that the entire upper body is a tree structure
    % robot with the left and right feet acting as the bases of the robot.
    % Since in this case there are two bases for the upper body, the forces
    % and moments of the upper body are distributed to both the legs
    % depending on the shift of the center of gravity of the upper body.
    %
    % This function would be suitable for calculating the dynamics for the
    % following scenarios : 
    %   1) motion of waving hand with no leg motion
    %   2) action of sitting down
    %   3) jumping scenarios (NOTE : this is a really bad modelling choice
    %   for this scenario but is the simplest.)
    %
    % @input : 
    % mass - Mass values of all the segments in a cell array. 
    % Ig - Inertia matrices for all the segments in a cell array.
    % CoG - z offset for CoG calculation for all the segments in a cell
    %       array.
    %
    % @output :
    % F - Force vectors of all the segments across all time steps in a 
    %     cell array.
    % M - Moment vectors of all the segments across all time steps in a 
    %     cell array.
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
        eval(sprintf('X_%s = pose(T, CoG{%d});', seg, j));
        
        % compute velocity and acceleration
        % [Xdot_<seg16{j}>, Xddot_<seg16{j}>] = vel_acc(X_<seg16{j}>, dt)
        eval(sprintf('[Xdot_%s, Xddot_%s] = vel_acc(X_%s, dt);', ...
                     seg, seg, seg));
    end
    
    % zero vector across all the time steps
    zero_fm = zeros(3, size(Xddot_Head, 2), 1);
    zero_le = zeros(3, size(X_Head, 2), 1);
    
    % compute force and moments on the head segment
    Fe = zero_fm; Me = zero_fm; Le = zero_le;
    [F_Head, M_Head] = newtontimeloop(mass{1}, Ig{1}, Xdot_Head, ...
        Xddot_Head, Fe, Me, Le);
    
    % compute force and moments on the right arm segments
    L_LowerArmR = get_pos_vec(X_LowerArmR, X_UpperArmR);
    L_RightHand = get_pos_vec(X_RightHand, X_LowerArmR);
    Fe = zero_fm; Me = zero_fm; Le = zero_le;
    [F_UpperArmR, M_UpperArmR, F_LowerArmR, M_LowerArmR, ...
        F_RightHand, M_RightHand] = backward3( ... 
        mass{4}, Ig{4}, Xdot_UpperArmR, Xddot_UpperArmR, ...
        mass{3}, Ig{3}, Xdot_LowerArmR, Xddot_LowerArmR, L_LowerArmR, ...
        mass{2}, Ig{2}, Xdot_RightHand, Xddot_RightHand, L_RightHand, ... 
        Fe, Me, Le);
    
    % compute force and moments on the left arm segments
    L_LowerArmL = get_pos_vec(X_LowerArmL, X_UpperArmL);
    L_LeftHand = get_pos_vec(X_LeftHand, X_LowerArmL);
    Fe = zero_fm; Me = zero_fm; Le = zero_le;
    [F_UpperArmL, M_UpperArmL, F_LowerArmL, M_LowerArmL, ...
        F_LeftHand, M_LeftHand] = backward3( ... 
        mass{7}, Ig{7}, Xdot_UpperArmL, Xddot_UpperArmL, ...
        mass{6}, Ig{6}, Xdot_LowerArmL, Xddot_LowerArmL, L_LowerArmL, ...
        mass{5}, Ig{5}, Xdot_LeftHand, Xddot_LeftHand, L_LeftHand, ...
        Fe, Me, Le);   
    
    % compute force and moments on the trunk segments
    L_Head = get_pos_vec(X_Head, X_UpperTrunk);
    L_UpperArmR = get_pos_vec(X_UpperArmR, X_UpperTrunk);
    L_UpperArmL = get_pos_vec(X_UpperArmL, X_UpperTrunk);
    L_MiddleTrunk = get_pos_vec(X_MiddleTrunk, X_LowerTrunk);
    L_UpperTrunk = get_pos_vec(X_UpperTrunk, X_MiddleTrunk);
    Le(:, :, 1) = L_Head; 
    Le(:, :, 2) = L_UpperArmR; 
    Le(:, :, 3) = L_UpperArmL;
    Fe(:, :, 1) = F_Head;       Me(:, :, 1) = M_Head; 
    Fe(:, :, 2) = F_UpperArmR;  Me(:, :, 2) = M_UpperArmR; 
    Fe(:, :, 3) = F_UpperArmL;  Me(:, :, 3) = M_UpperArmL;
    [F_LowerTrunk, M_LowerTrunk, F_MiddleTrunk, M_MiddleTrunk, ...
        F_UpperTrunk, M_UpperTrunk] = backward3( ...
        mass{16}, Ig{16}, Xdot_LowerTrunk, Xddot_LowerTrunk, ...
        mass{15}, Ig{15}, Xdot_MiddleTrunk, Xddot_MiddleTrunk, L_MiddleTrunk, ...
        mass{14}, Ig{14}, Xdot_UpperTrunk, Xddot_UpperTrunk, L_UpperTrunk, ...
        Fe, Me, Le);
    
    % compute the ratio for distribution of forces and moments on both
    % the legs
    upper_mass = []; upper_X = []; k = 1;
    for j = 1:nseg
        if j > 7 && j < 14
            continue;
        end
        eval(sprintf('upper_X(:, :, %d) = X_%s;', k, seg16{j}));
        upper_mass = [upper_mass; mass{j}];
        k = k + 1;
    end
    [upper_CoM, ~] = uppercom(upper_mass, upper_X);
    [ratio_l, ratio_r] = wtdistribute(upper_CoM, X_FootL, X_FootR);
    
    % compute force and moments on the left leg segments
    L_LowerTrunk = get_pos_vec(X_LowerTrunk, X_UpperLegL);
    L_UpperLegL = get_pos_vec(X_UpperLegL, X_LowerLegL);
    L_LowerLegL = get_pos_vec(X_LowerLegL, X_FootL);
    Le = L_LowerTrunk;
    [Fe, Me] = fmdistribute(F_LowerTrunk, M_LowerTrunk, ratio_l);
    [F_FootL, M_FootL, F_LowerLegL, M_LowerLegL, ...
        F_UpperLegL, M_UpperLegL] = backward3( ... 
        mass{11}, Ig{11}, Xdot_FootL, Xddot_FootL, ... 
        mass{12}, Ig{12}, Xdot_LowerLegL, Xddot_LowerLegL, L_LowerLegL, ...
        mass{13}, Ig{13}, Xdot_UpperLegL, Xddot_UpperLegL, L_UpperLegL, ...
        Fe, Me, Le);
    
    % compute force and moments on the right leg segments
    L_LowerTrunk = get_pos_vec(X_LowerTrunk, X_UpperLegR);
    L_UpperLegR = get_pos_vec(X_UpperLegR, X_LowerLegR);
    L_LowerLegR = get_pos_vec(X_LowerLegR, X_UpperLegR);
    Le = L_LowerTrunk;
    [Fe, Me] = fmdistribute(F_LowerTrunk, M_LowerTrunk, ratio_r);
    [F_FootR, M_FootR, F_LowerLegR, M_LowerLegR, ...
        F_UpperLegR, M_UpperLegR] = backward3( ... 
        mass{8}, Ig{8}, Xdot_FootR, Xddot_FootR, ...
        mass{9}, Ig{9}, Xdot_LowerLegR, Xddot_LowerLegR, L_LowerLegR, ...
        mass{10}, Ig{10}, Xdot_UpperLegR, Xddot_UpperLegR, L_UpperLegR, ...
        Fe, Me, Le);
    
    % store force and moments in a cell array for output 
    for j = 1:nseg 
        seg = seg16{j};
        eval(sprintf('F{%d} = F_%s;', j, seg));
        eval(sprintf('M{%d} = M_%s;', j, seg));
    end
    
end

