% Sophie SAKKA 

% Needs ShowJointFrames = [true false]; % [Origin markers, xyz Axes]

% 20 frames corresponding to each of the 20 joints (F1~F20)
vars = genvarname({'F1','F2','F3','F4','F5','F6','F7','F8','F9','F10','F11','F12','F13','F14','F15','F16','F17','F18','F19','F20'});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               F FRAMES                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For F frames (joint frames estimated by the software)
if ShowJointFrames(1) || ShowJointFrames(2)
    for j = 1:frames
        if ShowJointFrames(1)
            % Frame centers
            eval([vars{j} 'm = plot3(T_'  vars{j} '(1,4,1), T_'  vars{j} '(2,4,1), T_'  vars{j} '(3,4,1),''w.'',''MarkerSize'',17);']);
        end
        if ShowJointFrames(2)
            % Axes
            eval(['[O,xu,yu,zu]=AxisValues(T_' vars{j} '(:,:,1));']);
            eval(['X_' vars{j} ' = line([O(1), xu(1)],[O(2), xu(2)],[O(3), xu(3)],''LineWidth'',2,''Color'',''m'');']);
            eval(['Y_' vars{j} ' = line([O(1), yu(1)],[O(2), yu(2)],[O(3), yu(3)],''LineWidth'',2,''Color'',''y'');']);
            eval(['Z_' vars{j} ' = line([O(1), zu(1)],[O(2), zu(2)],[O(3), zu(3)],''LineWidth'',2,''Color'',''c'');']);
        end
    end
end