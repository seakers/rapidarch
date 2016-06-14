%% fuzzy_pareto_front_ranking.m
function indexes_fuzzy_pf = fuzzy_pareto_front_distance(metrics,max_distance)
    distances = compute_distances_to_pf(metrics);
    indexes_fuzzy_pf = distances < max_distance;
    
    %% Plot
    ms = 15;ms2 = 20;
    close all;
    figure;axes('Parent',gcf,'FontSize',18);
    plot(metrics(:,1),metrics(:,2),'k.','MarkerSize',ms);
    hold on;
    plot(metrics(indexes_fuzzy_pf,1),metrics(indexes_fuzzy_pf,2),'bo','MarkerSize',ms2);
    xlabel('Metric 1');ylabel('Metric 2');
end
