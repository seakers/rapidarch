function cycles = enum_cycles_dpf(A,startNode)
% This algorithm finds all elementary cycles in a directed graph that are
% rooted from one node. It mimicks the steps of finding the elementary
% cycles "by inspection", and is similar to the "depths-first" algorithms.
% Inputs:
%   A              - a square adjacency matrix representing the directed
%                      graph, where the row/column indices represents the
%                      nodes
%   startNode      - an integer rerpesenting the node from which all
%                     elementary cycles are rooted from
% Ouput:
%   cycles         - a Java ArrayList of ArrayList of integers, where each
%                    ArrayList of integers represents the sequence of nodes
%                    on a cycle, which begins and ends with startNode
%
% Example:
%   % SYSEN5400 Lecture 2 In-class question
% %   A = [0,1,1,0,0,0;
% %        1,0,0,0,0,0;
% %        1,0,0,0,0,1;
% %        1,1,1,0,1,0;
% %        0,0,0,1,0,0;
% %        0,0,0,1,1,0];
% %   cycles = enum_cycles_dpf(A,1);
%
% Example:
%   % A random square binary matrix
%   A = rand(7,7)>0.5;
%   cycles = enum_cycles_dpf(A,1);
%
%
%  Wenqi Yi, 1/30/2015

cycles = java.util.ArrayList;

if(all(A(startNode,:)) || all(A(:,startNode)))
    return
end

% Convert the adjancy matrix into an adjacency list (forward-star
% representation)
forward_star = cell(0);
for node = 1:size(A,1)
    forward_star{node} = find(A(node,:));
end

% Depth-first search algorithm

% Span the start node
incompletePaths = cell(java.util.ArrayList); % temperarory/incomplete paths ending with the nodes to span
for indx = 1:size(A,1)
    incompletePaths{indx} = java.util.ArrayList;
end
nodesToSpan = java.util.ArrayList;
toNodes = forward_star{startNode};
for indx = 1:length(toNodes)
    toNode = toNodes(indx);
    if(toNode~=startNode)
        incompletePath = java.util.ArrayList;
        intersectPaths = java.util.ArrayList;
        incompletePath.add(toNode);
        intersectPaths.add(incompletePath);
        incompletePaths{toNode} = intersectPaths;
        nodesToSpan.add(toNode);
    end
    
end

% Span one node at a time until all nodes are examined
while(~nodesToSpan.isEmpty())
    nodeToSpan = nodesToSpan.get(0);
    intersectPaths = incompletePaths{nodeToSpan};
    toNodes = forward_star{nodeToSpan};
    for toNodeIndx = 1:length(toNodes)
        toNode = toNodes(toNodeIndx);
        if(toNode==startNode)
            cycles.addAll(intersectPaths);
        else
            for indx = 1:intersectPaths.size()
                incompletePath = intersectPaths.get(indx-1);
                if(~incompletePath.contains(toNode))
                    newIncompletePath = java.util.ArrayList;
                    newIncompletePath.addAll(incompletePath);
                    newIncompletePath.add(toNode);
                    incompletePaths{toNode}.add(newIncompletePath);
                    if(~nodesToSpan.contains(toNode))
                        nodesToSpan.add(toNode);
                    end
                end
            end
        end
    end
    nodesToSpan.remove(0);
    incompletePaths{nodeToSpan}.clear();
end

% Add startNode to both ends of each sequence
for indx = 1:cycles.size()
    cycles.get(indx-1).add(0,startNode);
    cycles.get(indx-1).add(startNode);
end