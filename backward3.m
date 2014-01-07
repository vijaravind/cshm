function [F1, M1, F2, M2, F3, M3] = backward3( ...
                                        mass1, Ig1, X1dot, X1ddot, ...
                                        mass2, Ig2, X2dot, X2ddot, L2, ...
                                        mass3, Ig3, X3dot, X3ddot, L3, ...
                                        Fe, Me, Le)
    % [F1, M1, F2, M2, F3, M3] = backward3( ...
    %                               mass1, Ig1, X1dot, X1ddot, ...
    %                               mass2, Ig2, X2dot, X2ddot, L2, ...
    %                               mass3, Ig3, X3dot, X3ddot, L3, ...
    %                               Fe, Me, Le)
    %
    % Function to compute the forces and moments for the three serial links
    % through backward recursive computation. This function allows the 
    % entire human body (ie. 15 segments since Head is not
    % included) to be modelled as a combination of multiple serial
    % kinematic chains of 3 links. 
    %
    % link3 = "end-effector", link2 = middle link, link1 = base link
    % For an Arm, 3 = Hand, 2 = Lower Arm, 1 = Upper Arm
    % For Torso, 3 = Upper Trunk, 2 = Middle Trunk, 1 = Lower Trunk
    % For a Leg, 3 = UpperLeg/Foot, 2 = Lower Leg, 1 = Foot/UpperLeg
    %
    % @input : 
    % mass1, mass2, mass3 - Mass of each segment
    % Ig1, Ig2, Ig3 - Inertia matrices of each segment
    % X1dot, X2dot, X3dot - Veloctiy of each link
    % X1ddot, X2ddot, X3ddot - Acceleration of each link
    % L2, L3 - Position vector of the center of gravity of the link wrt
    %          the center of gravity of its antecedent.
    % Fe, Me - Forces and moments on the end-effector (j+1 terms for the
    %          end-effector). When the "end-effector" is the terminal link
    %          these values are zero.
    % Le - Position vector of the center of gravity of the next link to the
    %      end-effector. When the "end-effector" is the terminal link
    %      this value is zero.
    %
    % @output : 
    % F1, F2, F3 - matrices in which each column corresponds to the force
    %              of a particular link at a give time step.
    % M1, M2, M3 - matrices in which each column corresponds to the 
    %              moment of a particular link at a give time step.
    %
    [F3, M3] = newtontimeloop(mass3, Ig3, X3dot, X3ddot, Fe, Me, Le);
    [F2, M2] = newtontimeloop(mass2, Ig2, X2dot, X2ddot, F3, M3, L3);
    [F1, M1] = newtontimeloop(mass1, Ig1, X1dot, X1ddot, F2, M2, L2);
end

