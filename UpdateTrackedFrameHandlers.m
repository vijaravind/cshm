% Sophie SAKKA 

if ShowTrackedFrames(1) || ShowTrackedFrames(2)
    for j = 1:17
        if ShowTrackedFrames(1)
            % Frame centers
            eval(['set(' varst{j} 'm ,''XData'',T_' varst{j} '(1,4,i),''YData'', T_' varst{j} '(2,4,i),''ZData'', T_' varst{j} '(3,4,i))' ]);
        end
        if ShowTrackedFrames(2)
            % Axes
            eval(['[O,xu,yu,zu]=AxisValues(T_' varst{j} '(:,:,i));']);
            eval(['set(X_' varst{j} ',''XData'',[O(1), xu(1)],''YData'',[O(2), xu(2)],''Zdata'',[O(3), xu(3)])']);
            eval(['set(Y_' varst{j} ',''XData'',[O(1), yu(1)],''YData'',[O(2), yu(2)],''Zdata'',[O(3), yu(3)])']);
            eval(['set(Z_' varst{j} ',''XData'',[O(1), zu(1)],''YData'',[O(2), zu(2)],''Zdata'',[O(3), zu(3)])']);
        end
    end
end