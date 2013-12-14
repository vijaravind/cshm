function [F, M] = newton(mass, Ij, Xdot, Xddot, Fn, Mn, Ln)
    % [F, M] = newton(mass, Ij, Xdot, Xddot, Fn, Mn, Ln)
    %
    % Function to compute the total force and total moment acting on the
    % link at a given (SINGLE) time step.
    %
    % @input :
    % mass - Mass of the segment (scalar value in kg)
    % Ij - Inertia matrix of the segment (3 x 3 matrix)
    % Xdot - Velocity of the link wrt center of gravity (6 x 1 screw)
    % Xddot - Acceleration of the link wrt center of gravity (6 x 1 screw)
    % Fn - Force of the next link. This is a (3 x n) matrix where 'n'
    %      represents the number of 'next' links and each column
    %      corresponds to the force vector of 'one next' link.
    % Mn - Moment of the next link. This is a (3 x n) matrix where 'n'
    %      represents the number of 'next' links and each column
    %      corresponds to the moment vector of 'one next' link.
    % Ln - Position vector of the center of gravity of the next link wrt
    %      center of gravity of the current link. This is a (3 x n) matrix 
    %      where 'n' represents the number of 'next' links and each column
    %      corresponds to the position vector of 'one next' link.
    % NOTE : The order of the columns corresponding to 'next links' should
    % be the same in Fn, Mn and Ln.
    %
    % @output :
    % F - Total force acting on the link
    % M - Total moment acting on the link
    %
    
    % gravity vector
    gz = 9.81;
    gvec = [0; 0; gz];
    % assign to individual variables 
    v = Xdot(1:3);
    omega = Xdot(4:6);
    vdot = Xddot(1:3);
    omegadot = Xddot(4:6);
    
    % compute Fj and Mj
    Fj = mass * vdot;                                   % eq 9.69
    Mj = (Ij * omegadot) + cross(omega, (Ij * omega));  % eq 9.70
    
    % compute total forces and total moments from the next links
    assert(size(Fn, 2) == size(Mn, 2), ...
           'newton() : number of columns in Fn and Mn are different.');
    assert(size(Ln, 2) == size(Mn, 2), ...
           'newton() : number of columns in Ln and Mn are different.');
    totalFn = zeros(3,1);
    totalMn = zeros(3,1);
    totalcross = zeros(3,1);
    for k = 1:size(Ln, 2)
        totalFn = totalFn + Fn(:, k);
        totalMn = totalMn + Mn(:, k);
        totalcross = totalcross + cross(Ln(:, k), Fn(:, k));
    end
    
    % compute the total force and moments of the current link
    F = Fj - totalFn + (mass * gvec);   % eq 9.78
    M = Mj - totalMn - totalcross;      % eq 9.79
    
end

