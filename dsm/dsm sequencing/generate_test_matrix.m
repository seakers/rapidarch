function params = generate_test_matrix(N)
    params.N = N;
    % Generate random decision connectivity matrix
    params.MAX_CONNECT = 2;% assume scale of 1-5
    params.DEGREE_OF_CONNECT = 0.4;%this determines how sparse this matrix is
    params.CONNECTIVITIES = zeros(params.N,params.N);
    params.LABELS = cellfun(@(x) ['E' num2str(x)],num2cell(1:size(params.CONNECTIVITIES,1)),'UniformOutput',false)';
    for i = 1:params.N
        for j = 1:params.N
            if rand<params.DEGREE_OF_CONNECT
                params.CONNECTIVITIES(i,j) = 0;
            else
                params.CONNECTIVITIES(i,j) = randi(params.MAX_CONNECT);
            end
        end
    end
end