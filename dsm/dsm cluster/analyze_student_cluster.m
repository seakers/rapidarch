function analyze_student_cluster(str,params)
%     part = str2part(str,params);
    part = ind2part(str);
    
    score = fitness_function_dsm_clustering(part,params);
    fprintf('score = %d\n',score);
    cluster_matrix = PACK_cluster_matrix(part);
    DSM = params.CONNECTIVITIES;
    DSMLABEL = params.LABELS;
    [New_DSM_matrix, New_DSM_labels] = reorder_DSM_byCluster(DSM,cluster_matrix,DSMLABEL);
    
    graph_New_DSM_matrix=New_DSM_matrix;
    graph_DSM_matrix=DSM;
    for i = 1:params.N
        graph_New_DSM_matrix(i,i)=params.MAX_CONNECT;
        graph_DSM_matrix(i,i) = params.MAX_CONNECT;
    end
    
    graph_matrix2(graph_New_DSM_matrix,'','','Student DSM', New_DSM_labels, New_DSM_labels, 0, cluster_matrix);
end