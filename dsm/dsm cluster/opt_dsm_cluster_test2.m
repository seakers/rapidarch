%% opt_dsm_cluster_test2.m
function [x,fval,params] = opt_dsm_cluster_test2(varargin)
% Example of usage: 
% 
%   load inclass5_matrix % loads matrices syn, int, A=syn, A2=syn-alpha*int
%   in_out_importance = 1; desired_num_clusters=3; num_cluster_penalty=5;
%   [x,fval,params] = opt_dsm_cluster_test2(A2, in_out_importance, desired_num_clusters, num_cluster_penalty)
%
%   DSM is assumed symmetric and non-overlapping in this version
%   See fitness_function_dsm_clustering_vectorized fore info on how other
%   parameters are used
%
%   May have to play around with values for defining A2, in_out_importance,
%   desired_num_clusters, num_cluster_penalty
%
%   OUTPUT: x is a vector of which cluster a column belongs to. This
%   problem is a partitioning problem and so the value in x represents
%   which partition a column belongs to. The 

    if nargin == 4 % Input matrix and other params given
        params.CONNECTIVITIES = varargin{1};% This is the DSM
        params.N = size(params.CONNECTIVITIES,1);
        params.MAX_CONNECT = max(max(params.CONNECTIVITIES));
        params.IN_OUT_IMPORTANCE_RATIO = varargin{2};
        params.DESIRED_NUM_CLUSTERS = varargin{3};
        params.NUM_CLUSTER_PENALTY = varargin{4};
    else % create random test matrix and parameters
        params = generate_test_matrix();
    end
    
    % Call GA
    nvars = params.N;
    options = gaoptimset('PopulationSize',200,'Generations',200,'PlotFcns',@gaplotbestf,...
        'Display','iter','StallGenLimit',50,'Vectorized','on','CrossoverFcn',@PACK_crossover2,'MutationFcn',@PACK_mutation2,'CreationFcn',@PACK_create);
    [x,fval,~] = ga(@(x)fitness_function_dsm_clustering_vectorized(x,params),nvars,options);
    
    print_solution(x(1,:));
    
    % Plot original and new DSM (reuse DSM graph function)
%     DSM = params.CONNECTIVITIES>0;

    DSM = (params.CONNECTIVITIES + params.CONNECTIVITIES');
    DSMLABEL = cellfun(@(x) ['E' num2str(x)],num2cell(1:size(DSM,1)),'UniformOutput',false)';
    cluster_matrix = PACK_cluster_matrix(x);
    [New_DSM_matrix, New_DSM_labels] = reorder_DSM_byCluster(DSM,cluster_matrix,DSMLABEL);
    
    % TODO Check that we really need to do this (He does it). 
    graph_New_DSM_matrix=New_DSM_matrix;
    graph_DSM_matrix=DSM;
    for i = 1:params.N
        graph_New_DSM_matrix(i,i)=params.MAX_CONNECT;
        graph_DSM_matrix(i,i) = params.MAX_CONNECT;
    end
    
    % Plot
    graph_matrix2(graph_DSM_matrix,'','','Original DSM', DSMLABEL, DSMLABEL, 0);
    graph_matrix2(graph_New_DSM_matrix,'','','New DSM', New_DSM_labels, New_DSM_labels, 0, cluster_matrix);
    
    params.newDSM = New_DSM_matrix;
end



