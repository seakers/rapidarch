%% non_dominated_sorting.m
function rankings = non_dominated_sorting(metrics)
    np = size(metrics,1);
    rankings = -1*ones(np,1);
    points_to_rank = metrics;
    r = 0;
    indexes = 1:np';
    while size(points_to_rank,1)>0
        non_dominated = paretofront(points_to_rank);
        indexes_dominated = indexes(non_dominated==0);
        indexes_nondominated = indexes(non_dominated);
        rankings(indexes_nondominated) = r;
%         indexes = find(non_dominated==0);
        points_to_rank = points_to_rank(~non_dominated,:);
        indexes = indexes_dominated;
        r=r+1;
    end
    
    %% Plot
    ms = 20;ms2 = 15;
    close all;
    figure;axes('Parent',gcf,'FontSize',18);
    plot(metrics(:,1),metrics(:,2),'k.','MarkerSize',ms);
    xlabel('Metric 1');ylabel('Metric 2');
    
    figure;axes('Parent',gcf,'FontSize',18);
    plot(metrics(:,1),metrics(:,2),'k.','MarkerSize',ms);
    hold on;
    plot(metrics(rankings==0,1),metrics(rankings==0,2),'bo','MarkerSize',ms2);
    xlabel('Metric 1');ylabel('Metric 2');
    
    figure;axes('Parent',gcf,'FontSize',18);
    plot(metrics(:,1),metrics(:,2),'k.','MarkerSize',ms);
    hold on;
    plot(metrics(rankings==0,1),metrics(rankings==0,2),'bo','MarkerSize',ms2);
    plot(metrics(rankings==1,1),metrics(rankings==1,2),'ro','MarkerSize',ms2);
    xlabel('Metric 1');ylabel('Metric 2');
    
    figure;axes('Parent',gcf,'FontSize',18);
    plot(metrics(:,1),metrics(:,2),'k.','MarkerSize',ms);
    hold on;
    plot(metrics(rankings==0,1),metrics(rankings==0,2),'bo','MarkerSize',ms2);
    plot(metrics(rankings==1,1),metrics(rankings==1,2),'ro','MarkerSize',ms2);
    plot(metrics(rankings==2,1),metrics(rankings==2,2),'go','MarkerSize',ms2);
    xlabel('Metric 1');ylabel('Metric 2');
end