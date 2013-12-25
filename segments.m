function [seg16, nseg] = segments()
    % [seg16, nseg] = segments()
    %
    % Function to obtain the names for all the 16 segments.
    % @input : 
    %   <empty>
    % @output : 
    % seg16 - Cell array containing the names of all the 16 segments.
    % nseg - total number of segments
    %
    nseg = 16;  % number of segments
    % segment names
    seg16 = {
        'Head', ...
        'RightHand', 'LowerArmR', 'UpperArmR', ...
        'LeftHand', 'LowerArmL', 'UpperArmL', ...
        'FootR', 'LowerLegR', 'UpperLegR', ...
        'FootL', 'LowerLegL', 'UpperLegL', ...
        'UpperTrunk', 'MiddleTrunk', 'LowerTrunk', ...
    };
end

