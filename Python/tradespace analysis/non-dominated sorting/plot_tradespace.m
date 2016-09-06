function front = plot_tradespace(archs,metrics)
    front = paretofront([metrics(:,1) -metrics(:,2)]);
    plot(metrics(:,1),metrics(:,2),'bx','ButtonDownFcn', {@mycallback_function,archs,metrics(:,1),metrics(:,2)});
    hold on;
    plot(metrics(front,1),metrics(front,2),'go','ButtonDownFcn', {@mycallback_function,archs(front,:),metrics(front,1),metrics(front,2)});
    xlabel('Metric 1');
    ylabel('Metric 2');
end
function mycallback_function(src,eventdata,archs,costs,reliabs)
    % Do not delete apparently unused parametes src, eventdata!!!
    
    % Get mouse position where user clicked
	mouse = get(gca, 'CurrentPoint');
	xmouse = mouse(1,1);
	ymouse = mouse(1,2);
    
    % Find closes point in dataset
	[~, i] = min(abs((costs - xmouse)/(max(costs) - min(costs))).^2+abs((reliabs - ymouse)/(max(reliabs) - min(reliabs))).^2);
	
    % Print info about corresponding architecture
    fprintf('Arch # %d = %s, Metric1  = %f, Metric 2 = %f\n',i,arch2str(archs(i,:)),costs(i),reliabs(i));
end
function str = arch2str(arch)
    % Print info about architecture
    str = num2str(arch);
end