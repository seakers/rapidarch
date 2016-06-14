function penalties = fitness_function_dsm_clustering_vectorized(pop,params)
    narc = size(pop,1);
    penalties = zeros(narc,1);
    gamma = params.NUM_CLUSTER_PENALTY;
    lambda = params.IN_OUT_IMPORTANCE_RATIO; 
    for a = 1:narc
        x = pop(a,:);
        C = params.CONNECTIVITIES;
        normC = sum(sum(C));
        for i = 1:params.N
            for j = i+1:params.N
                if x(i) == x(j)
                    penalties(a) = penalties(a) - lambda* C(i,j)/normC;
                else
                    penalties(a) = penalties(a) + C(i,j)/normC;
                end
            end
        end
        %add penalty for number of clusters
        ncl = length(unique(x));
        penalties(a) = penalties(a)+ gamma*((ncl - params.DESIRED_NUM_CLUSTERS)/params.N)^2;
    end
end