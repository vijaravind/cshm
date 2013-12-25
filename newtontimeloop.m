function [F, M] = newtontimeloop(mass, Ig, Xdot, Xddot, Fn, Mn, Ln)
    % [F, M] = newton(mass, Ig, Xdot, Xddot, Fn, Mn, Ln)
    %
    % Function to compute the total force and total moment acting on the
    % link at ALL the time steps.
    % @input :
    % mass - Mass of the segment (scalar value in kg)
    % Ig - Inertia matrix of the segment (3 x 3 matrix)
    % Xdot - Velocity of the link wrt center of gravity (6 x 1 screw)
    % Xddot - Acceleration of the link wrt center of gravity (6 x 1 screw)
    % Fn - Force of the next link. This is a (3 x t x n) matrix where 'n'
    %      represents the number of 'next' links and each column
    %      corresponds to the force vector of 'one next' link. Here 't'
    %      indicates the time steps.
    % Mn - Moment of the next link. This is a (3 x t x n) matrix where 'n'
    %      represents the number of 'next' links and each column
    %      corresponds to the moment vector of 'one next' link. Here 't'
    %      indicates the time steps.
    % Ln - Position vector of the center of gravity of the next link wrt
    %      center of gravity of the current link. This is a (3 x t x n) 
    %      matrix where 'n' represents the number of 'next' links and 
    %      each column corresponds to the position vector of 'one next' 
    %      link. Here 't' indicates the time steps.
    % NOTE : The order of the pages corresponding to 'next links' should
    % be the same in Fn, Mn and Ln. Also in this case Fn, Mn and Ln are 
    % all 3D matrices where the third dimension is 'next links' and time
    % is second dimension.
    % @output :
    % F - Total force acting on the link for ALL the time steps
    % M - Total moment acting on the link for ALL the time steps
    %
    assert(size(Xddot, 2) <= size(Xdot, 2), ...
           'newtontimeloop() : size(Xddot, 2) <= size(Xdot, 2)');
    assert(size(Fn, 3) == size(Mn, 3), ... 
           'newtontimeloop() : size(Fn, 3) == size(Mn, 3)');
    assert(size(Ln, 3) == size(Mn, 3), ... 
           'newtontimeloop() : size(Ln, 3) == size(Mn, 3)');       
    assert(size(Ln, 2) >= size(Xddot, 2), ...
           'newtontimeloop() : size(Ln, 2) >= size(Xddot, 2)'); 
    nsteps = size(Xddot, 2);
    nnextl = size(Fn, 3);
    F = [];
    M = [];
    for k = 1:nsteps
        kp = k + 2; % position index
        kv = k + 1; % veocity index
        ka = k;     % acceleration index
        % convert to 2D matrix
        Fn_k = reshape(Fn(:, k, :), 3, nnextl);
        Mn_k = reshape(Mn(:, k, :), 3, nnextl);
        Ln_k = reshape(Ln(:, kp, :), 3, nnextl);
        % call newton-euler method
        [Fk, Mk] = newton(mass, Ig, Xdot(:, kv), Xddot(:, ka), ...
                          Fn_k, Mn_k, Ln_k);
        F = [F, Fk];
        M = [M, Mk];
    end
end

