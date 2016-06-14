function params = generate_test_matrix()
    params.N = 4;
    params.IN_OUT_IMPORTANCE_RATIO = 1;
    params.NUM_CLUSTER_PENALTY = 1;%to avoid solutions with one cluster
    params.DESIRED_NUM_CLUSTERS = params.N/2;
    % Generate random decision connectivity matrix
    params.MAX_CONNECT = 5;% assume scale of 1-5
    params.DEGREE_OF_CONNECT = 0.4;%this determines how sparse this matrix is
    params.CONNECTIVITIES = zeros(params.N,params.N);

    for i = 1:params.N
        for j = i+1:params.N
            if rand<params.DEGREE_OF_CONNECT
                params.CONNECTIVITIES(i,j) = 0;
                params.CONNECTIVITIES(j,i) = 0;
            else
                sign = 2*(rand>0.5)-1;
                params.CONNECTIVITIES(i,j) = sign*randi(params.MAX_CONNECT);
                params.CONNECTIVITIES(j,i) = params.CONNECTIVITIES(i,j);
            end
        end
    end
end