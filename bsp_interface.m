function [mass, Ig, CoM] = bsp_interface(P, M)
    % 
    %
    % Function to interface bsp_arg() function output with the input for
    % force and moment computation using the Newton-Euler method. 
    % @input :
    % P - parameters [P1 : P41]
    % M - whole body mass
    % @output :
    % 
    % 
    
    % variables to hold string terms that will be concatenated to form
    % variable names
    [seg16, nseg] = segments();
    % BSP
    bsp = bsp_arg(P, M);
    % interface
    mass = {};
    Ig = {};
    CoM = {};
    for j = 1:nseg
        seg = seg16{j};
        if size(strfind(seg, 'Hand'), 2) ~= 0
            mass{j} = bsp.hand.mass;
            Ig{j} = diag(bsp.hand.I);
            CoM{j} = [0; 0; bsp.hand.CoM];
            continue;
        end
        if size(strfind(seg, 'LowerArm'), 2) ~= 0
            mass{j} = bsp.forearm.mass;
            Ig{j} = diag(bsp.forearm.I);
            CoM{j} = [0; 0; bsp.forearm.CoM];
            continue;
        end
        if size(strfind(seg, 'UpperArm'), 2) ~= 0
            mass{j} = bsp.upperarm.mass;
            Ig{j} = diag(bsp.upperarm.I);
            CoM{j} = [0; 0; bsp.upperarm.CoM];
            continue;
        end
        if size(strfind(seg, 'Foot'), 2) ~= 0
            mass{j} = bsp.foot.mass;
            Ig{j} = diag(bsp.foot.I);
            CoM{j} = [0; 0; bsp.foot.CoM];
            continue;
        end
        if size(strfind(seg, 'LowerLeg'), 2) ~= 0
            mass{j} = bsp.shank.mass;
            Ig{j} = diag(bsp.shank.I);
            CoM{j} = [0; 0; bsp.shank.CoM];
            continue;
        end
        if size(strfind(seg, 'UpperLeg'), 2) ~= 0
            mass{j} = bsp.thigh.mass;
            Ig{j} = diag(bsp.thigh.I);
            CoM{j} = [0; 0; bsp.thigh.CoM];
            continue;
        end
        if size(strfind(seg, 'Head'), 2) ~= 0
            mass{j} = bsp.head.mass;
            Ig{j} = diag(bsp.head.I);
            CoM{j} = [0; 0; bsp.head.CoM];
            continue;
        end
        if size(strfind(seg, 'UpperTrunk'), 2) ~= 0
            mass{j} = bsp.utrunk.mass;
            Ig{j} = diag(bsp.utrunk.I);
            CoM{j} = [0; 0; bsp.utrunk.CoM];
            continue;
        end
        if size(strfind(seg, 'MiddleTrunk'), 2) ~= 0
            mass{j} = bsp.mtrunk.mass;
            Ig{j} = diag(bsp.mtrunk.I);
            CoM{j} = [0; 0; bsp.mtrunk.CoM];
            continue;
        end
        if size(strfind(seg, 'LowerTrunk'), 2) ~= 0
            mass{j} = bsp.ltrunk.mass;
            Ig{j} = diag(bsp.ltrunk.I);
            CoM{j} = [0; 0; bsp.ltrunk.CoM];
            continue;
        end
    end
end

