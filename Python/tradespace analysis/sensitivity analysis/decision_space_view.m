function decision_space_view(S,C)
    for i = 1:size(S,2)
        figure;plot(C(:,i),S(:,i),'bx','ButtonDownFcn', {@mycallback_function,S(:,i),C(:,i)});

        hold on;
        xlabel('Connectivity');
        ylabel('Sensitivity');
        title(['Metric ' num2str(i)]);
    end
    
end
function mycallback_function(src,eventdata,S,C)
    % Do not delete apparently unused parametes src, eventdata!!!
    
    % Get mouse position where user clicked
	mouse = get(gca, 'CurrentPoint');
	xmouse = mouse(1,1);
	ymouse = mouse(1,2);
    
    % Find closes point in dataset
	[~,i] = min( abs((C - xmouse)/(max(C)-min(C))).^2+abs((S - ymouse)/(max(S)-min(S))).^2 );
	
    % Print info about corresponding architecture
    fprintf('Decision # %d , Sensitivity = %f, Connectivity = %f\n',i,S(i),C(i));
end
