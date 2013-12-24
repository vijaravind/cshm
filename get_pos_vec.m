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
    nsteps = size(Xc, 2);
    assert(nsteps == size(Xp, 2), ...
           'get_pos_vec() : nsteps == size(Xp, 2)');
    for k = 1:nsteps
        L(:, :, k) = Xc(1:3, k) - Xp(1:3, k);
    end
end

