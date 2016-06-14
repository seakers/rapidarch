function penalties = fitness_function_dsm_clustering(x,params)
    penalties = 0;
    gamma = params.NUM_CLUSTER_PENALTY;
    lambda = params.IN_OUT_IMPORTANCE_RATIO; 
    C = params.CONNECTIVITIES;
    normC = sum(sum(C));
    for i = 1:params.N
        for j = i+1:params.N
            if x(i) == x(j)
                penalties = penalties - lambda* C(i,j)/normC;
            else
                penalties = penalties + C(i,j)/normC;
            end
        end
    end
    %add penalty for number of clusters
    ncl = length(unique(x));
    penalties = penalties+ gamma*((ncl - params.N/2)/params.N)^2;
end