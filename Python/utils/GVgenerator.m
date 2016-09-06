function GVgenerator(dsm, params)
%% GVgenerator.m
% This function generates a text file that can be directly red by GraphViz
% to genereate a graph. 
% Inputs: 
%           dsm is an N x N square adjacency matrix
%           varargin{1} is an optional parameter containing a cell array of
%           strings with the labels of the nodes
%           varargin{2} is an optional parameter containing a matrix 
% 
% Example: GVgeneator(rand(5,5)>0.5)
% Daniel Selva
% <ds925@cornell.edu>
% 5/16/2016
%

%% Begin

    % Constants
    MIN_FS = 12;
    MAX_FS = 24;
    MIN_TH = 2;
    MAX_TH = 5;
    
    %% Parameters
    % Filename
    N = size(dsm,1);
    if isfield(params,'filename')
        filename = params.filename;
    else
        filename = 'test.gv';% default file name
    end
        
    % Node names and fontsizes
    if isfield(params,'node_labels')
        node_labels = params.node_labels;
    else
        node_labels = cell(N,1);
        node_fontsizes = zeros(N,1);
        importances = diag(dsm);
        for i = 1:N 
            node_labels{i} = ['Node' num2str(i)];% default node names
            if isfield(params,'node_sizes')
                if strcmp(params.node_sizes,'proportional')
                    node_fontsizes(i) = MIN_FS + round((MAX_FS-MIN_FS)*(importances(i)-min(importances))/(max(importances) - min(importances)));
                else
                    node_fontsizes(i) = 12;% default fontsizes
                end
            else
                node_fontsizes(i) = 12;% default fontsizes
            end
        end
    end
    
    % Edge properties
    
    edge_thickness = zeros(N,N);
    for i = 1:N
        for j = 1:N
            if isfield(params,'edge_thickness')
                if strcmp(params.edge_thickness,'proportional')
                    edge_thickness(i,j) = MIN_TH + round((MAX_TH-MIN_TH)*(dsm(i,j)-min(min(dsm)))/(max(max(dsm)) - min(min(dsm))));
                else
                    edge_thickness(i,j) = 1;
                end
            else
                edge_thickness(i,j) = 1;
            end
        end
    end




    fid = fopen(filename, 'w');
    fprintf(fid,'digraph test {\n');
    
    % Write one line per node
    for i = 1:N
        line = [node_labels{i} ' [style = filled, fixedsize = false, shape = box, fontsize = ' num2str(node_fontsizes(i)) ' ] '];
        fprintf(fid,'%s\n',line);
    end

    % Write one line per edge
    for i = 1:N
        for j = 1:N
            if dsm(i,j)>0
                line = [node_labels{i} ' -> ' node_labels{j} ' [penwidth =  ' num2str(edge_thickness(i,j)) ' , color = "black"] ' ];
                fprintf(fid,'%s\n',line);
            end
        end
    end
    fprintf(fid,'}');
    fclose(fid);
end


