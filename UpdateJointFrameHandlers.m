% Sophie SAKKA 

if ShowJointFrames(1) || ShowJointFrames(2)
    for j = 1:frames
        if ShowJointFrames(1)
            % Frame centers
            eval(['set(' vars{j} 'm ,''XData'',T_' vars{j} '(1,4,i),''YData'', T_' vars{j} '(2,4,i),''ZData'', T_' vars{j} '(3,4,i))' ]);
        end
        if ShowJointFrames(2)
            % Axes
            eval(['[O,xu,yu,zu]=AxisValues(T_' vars{j} '(:,:,i));']);
            eval(['set(X_' vars{j} ',''XData'',[O(1), xu(1)],''YData'',[O(2), xu(2)],''Zdata'',[O(3), xu(3)])']);
            eval(['set(Y_' vars{j} ',''XData'',[O(1), yu(1)],''YData'',[O(2), yu(2)],''Zdata'',[O(3), yu(3)])']);
            eval(['set(Z_' vars{j} ',''XData'',[O(1), zu(1)],''YData'',[O(2), zu(2)],''Zdata'',[O(3), zu(3)])']);
        end
    end
end