%% fuzzy_pareto_front.m
function indexes_fuzzy_pf = fuzzy_pareto_front(metrics,max_ranking)
    rankings = non_dominated_sorting(metrics);
    indexes_fuzzy_pf = rankings<=max_ranking;

end