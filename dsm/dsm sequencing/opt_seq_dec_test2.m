%% opt_seq_dec_test.m
function [x,fval,params] = opt_seq_dec_test2(varargin)
    %This function optimizes the sequence of decisions of a DSM using a
    %genetic algorithm. While executing, you will see a printout of the
    %progress of the genetic algorithm. Once finished, this function plots
    %out the original DSM and the new DSM.
    %
    %INPUTS: varagin should be a nxn matrix containing information about
    %your DSM. It is assumed that any positive number in the matrix should
    %be penalized, with higher numbers representing higher penalties.
    %
    %OUTPUTS: This function will plot out your orginal DSM and the
    %approximately optimal DSM. x is the optimized sequence, assuming 1 is
    %the first row of your orignal DSM. fval is the penalty score
    %associated with the new DSM. params is a cell struct that contains the
    %CONNECTIVITIES (new DSM matrix), N (the size of your matrix), and
    %LABELS (the original sequencing used). 


    if nargin == 0
        params = generate_test_matrix;
    elseif nargin == 1 && isstruct(varargin{1})
        params = varargin{1};
    else
        params.CONNECTIVITIES = varargin{1};
        params.N = size(params.CONNECTIVITIES,1);
        params.LABELS = cellfun(@(x) ['E' num2str(x)],num2cell(1:size(params.CONNECTIVITIES,1)),'UniformOutput',false)';
    end
    
    fprintf('Original sequence score: %.f\n',fitness_function_dsmseq2(1:params.N,params));
    % Call GA
    nvars = params.N;
    
    options = gaoptimset('PopulationSize',500,'Generations',200,'PlotFcns',@gaplotbestf,'Display','iter');
    options = gaoptimset(options,'CreationFcn',@create_permutations, ...
    'CrossoverFcn',@crossover_permutation, 'StallGenLimit',100,...
    'MutationFcn',@mutate_permutation,'Vectorized','on');
    [x,fval,~] = ga(@(x)fitness_function_dsmseq_vectorized(x,params),nvars,options);
    fprintf('Final sequence %s, score: %.f\n',StringArraytoStringWithSpaces(params.LABELS(x{1})), fitness_function_dsmseq2(x{1},params));
   % Plot original and new DSM (reuse DSM graph function)
    DSM = params.CONNECTIVITIES ;
    DSMLABEL = params.LABELS;
    
    % TODO Check that we really need to do this (He does it). 
    graph_New_DSM_matrix=reorder_dsm(DSM,x{1});
    New_DSM_labels = DSMLABEL(x{1});
    graph_DSM_matrix=DSM;
    for i = 1:params.N
        graph_New_DSM_matrix(i,i)=0;
        graph_DSM_matrix(i,i) = 0;
    end
    save results_seq
    
    % Plot
    graph_matrix2(graph_DSM_matrix,'','','Original DSM', DSMLABEL, DSMLABEL, 0);
    graph_matrix2(graph_New_DSM_matrix,'','','New DSM', New_DSM_labels, New_DSM_labels, 0);
    
end

