function [X] = pose(T)
    % [X] = pose(T)
    % 
    % Function to convert the homogenous transformation matrix to a 6x1
    % screw.
    % @input : 
    % T - 4x4 homogenous transformation matrix of every time step (this is
    %     a 3D matrix)
    % @output :
    % X - 6x1 position screw [px; py; pz; rx; ry; rz] of every time step
    %     (each column represents the pose at one time step)
    %
    nsteps = size(T, 3);
    assert(nsteps >= 1, ...
           'pose() : problem with sample size ie. less than 1');
    X = [];
    for k = 1:nsteps
        Pk = T(1:3, 4, k);  % position vector
        % convert rotation matrix to vector
        uak = vrrotmat2vec(T(1:3, 1:3, k));
        Rk = uak(1, 1:3) * uak(1, 4);  % rotation vector
        % pose screw
        Xk = [Pk; transpose(Rk)];
        X = [X, Xk];
    end
end

