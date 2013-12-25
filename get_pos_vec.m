function [L] = get_pos_vec(Xc, Xp)
    % [L] = get_pos_vec(Xc, Xp)
    % 
    % Function to compute the position vector of the center of gravity 
    % of the link wrt the center of gravity of its antecedent.
    % @input : 
    % Xc - Position screw of the center of gravity of the link wrt to 
    %      the global frame for all time steps.
    % Xp - Position screw of the center of gravity of the antecedant wrt 
    %      to the global frame for all time steps.
    % @output :
    % L - Position vector (3 x 1) of the center of gravity of the link  
    %     wrt the center of gravity of its antecedent for all time steps.
    %
    assert(size(Xc, 2) == size(Xp, 2), ...
           'get_pos_vec() : size(Xc, 2) == size(Xp, 2)');
    L(1:3, :) = Xc(1:3, :) - Xp(1:3, :);
end

