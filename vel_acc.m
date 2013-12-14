function [Xdot, Xddot] = vel_acc(X, dt)
    % [Xdot, Xddot] = vel_acc(X)
    % 
    % Function to compute the velocity and acceleartion screws using 
    % second order finite difference derivation at every time step.
    % @input :
    % X - (6 x nsamples) matrix in which each column represents the pose 
    %     at a particular time step
    % dt - Sampling time in second
    % @output :
    % Xdot - (6 x nsamples-2) matrix in which each column represents the  
    %        velocity screw at a particular time step
    % Xddot - (6 x nsamples-4) matrix in which each column represents the  
    %        acceleration screw at a particular time step
    %
    nsteps = size(X, 2);
    assert(nsteps >= 5, ...
           'velocity() : problem with sample size ie. less than 5');
    Xdot = [];
    Xddot = [];
    % velocity computation
    for k = 2:nsteps-1
        Xdotk = (X(:, k+1) - X(:, k-1)) / (2 * dt);
        Xdot = [Xdot, Xdotk];
    end
    % acceleration computation
    for k = 3:nsteps-2
        Xddotk = (X(:, k+2) - (2*X(:, k)) + X(:, k-2) ) / (4 * dt^2);
        Xddot = [Xddot, Xddotk];
    end
end

