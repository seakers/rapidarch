function plot_25D(archs,metrics)
    % archs = Narcs x Ndec matrix
    % metrics = Narcs x Nmetrics matrix
    % Plots metrics(:,1) as a function of metrics(:,2) using metrics(:,3)
    % in Marker color. By default, metrics(:,3) is divided in 5 bins. 
    % Assumes use of mouse interruptions function test_plot (must be
    % supplied by user), but can also get rid of that. 
    % 
    % Usage: plot_25D(archs,metrics)
    
    metric1 = metrics(:,1);
    metric2 = metrics(:,2);
    metric3 = metrics(:,3);

    % Defines 5 bins for metric 3
    edges = [0 0.2 0.4 0.6 0.8 1.0];
    [~,bin] = histc(metric3,edges);%bin tells me to what bin each architecture belongs (1-5)

    % Plot archs in each bin with different colors
    f = figure;
    ax = axes('Parent',f);
    colors = {'k','r','y','g','b'};
    plot(metric1(bin==1),metric2(bin==1),'Marker','d','Parent',ax,'MarkerSize', 10, 'MarkerEdgeColor',colors{1}, 'MarkerFaceColor',colors{1},'LineStyle','None', ...
        'ButtonDownFcn', {@test_plot,archs(bin==1,:),metrics(bin==1,:)});
    hold on;

    plot(metric1(bin==2),metric2(bin==2),'Marker','d','Parent',ax,'MarkerSize', 10, 'MarkerEdgeColor',colors{2}, 'MarkerFaceColor',colors{2},'LineStyle','None', ...
        'ButtonDownFcn', {@test_plot,archs(bin==2,:),metrics(bin==2,:)});

    plot(metric1(bin==3),metric2(bin==3),'Marker','d','Parent',ax,'MarkerSize', 10, 'MarkerEdgeColor',colors{3}, 'MarkerFaceColor',colors{3},'LineStyle','None', ...
        'ButtonDownFcn', {@test_plot,archs(bin==3,:),metrics(bin==3,:)});

    plot(metric1(bin==4),metric2(bin==4),'Marker','d','Parent',ax,'MarkerSize', 10, 'MarkerEdgeColor',colors{4}, 'MarkerFaceColor',colors{4},'LineStyle','None', ...
        'ButtonDownFcn', {@test_plot,archs(bin==4,:),metrics(bin==4,:)});

    plot(metric1(bin==5),metric2(bin==5),'Marker','d','Parent',ax,'MarkerSize', 10, 'MarkerEdgeColor',colors{5}, 'MarkerFaceColor',colors{5},'LineStyle','None', ...
        'ButtonDownFcn', {@test_plot,archs(bin==5,:),metrics(bin==5,:)});

    % Legend and labels: can customize this.
    grid on;
    xlabel('Metric 1');
    ylabel('Metric 2');
    leg = legend({'Metric3:Bin 1','Metric3:Bin 2','Metric3:Bin 3','Metric3:Bin 4','Metric3:Bin 5'});
    set(leg,'Location','Best');

end
