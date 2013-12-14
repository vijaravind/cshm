% Sophie SAKKA 

% Needs ShowTrackedFrames = [false true]; % [Origin markers, xyz Axes]

% frames corresponding to the tracked markers (TR17)
varst = genvarname({'TR1','TR2','TR3','TR4','TR5','TR6','TR7','TR8','TR9','TR10','TR11','TR12','TR13','TR14','TR15','TR16','TR17'});


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              TR FRAMES                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For TR frames (segment frames tracked)
if ShowTrackedFrames(1) || ShowTrackedFrames(2)
    for j = 1:tracked
        if ShowTrackedFrames(1)
            % Frame centers
            eval([varst{j} 'm = plot3(T_'  varst{j} '(1,4,1), T_'  varst{j} '(2,4,1), T_'  varst{j} '(3,4,1),''b.'',''MarkerSize'',17);']);
        end
        if ShowTrackedFrames(2)
            % Axes
            eval(['[O,xu,yu,zu]=AxisValues(T_' varst{j} '(:,:,1));']);
            eval(['X_' varst{j} ' = line([O(1), xu(1)],[O(2), xu(2)],[O(3), xu(3)],''LineWidth'',2,''Color'',[0.5 0 0]);']);
            eval(['Y_' varst{j} ' = line([O(1), yu(1)],[O(2), yu(2)],[O(3), yu(3)],''LineWidth'',2,''Color'',[0 0.5 0]);']);
            eval(['Z_' varst{j} ' = line([O(1), zu(1)],[O(2), zu(2)],[O(3), zu(3)],''LineWidth'',2,''Color'',[0 0 0.5]);']);
        end
    end
end
