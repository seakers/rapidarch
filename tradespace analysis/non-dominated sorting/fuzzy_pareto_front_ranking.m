%% fuzzy_pareto_front_ranking.m
function indexes_fuzzy_pf = fuzzy_pareto_front_ranking(metrics,max_ranking)
    rankings = non_dominated_sorting(metrics);
    indexes_fuzzy_pf = rankings<=max_ranking;
    
    %% Plot
    ms = 15;ms2 = 20;
    close all;
    figure;axes('Parent',gcf,'FontSize',18);
    plot(metrics(:,1),metrics(:,2),'k.','MarkerSize',ms);
    hold on;
    plot(metrics(indexes_fuzzy_pf,1),metrics(indexes_fuzzy_pf,2),'bo','MarkerSize',ms2);
    xlabel('Metric 1');ylabel('Metric 2');
end