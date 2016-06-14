function cycles = enum_cycles_bfs(A,start)
%% enum_cycles_bfs.m
% This algorithm enumerates all cycles of a digraph that start and end with
% node 'start'. It works by brute-force, expanding all unvisited nodes and checking 
% for whether the current path is a cycle. Note that much more efficient algorithms
% based on adaptations of depth-first search exist, such as Tarjan's
% algorithm. See the following paper for a good overview: 
% Ref: Johnson D. B., "Finding all elementary circuits in a directed
% graph", SIAM J. Comput(4):1, 1975
% 
% Input: 'A' is a matrix representing the adjacent interactions of the graph
% Output: 'cycles' is a Java List of Java Lists, where each List represents a cycle as
% a sequence of nodes identified by integers.
%
% Example:
% A=rand(7,7)>0.5
% cycles = enum_cycles_bfs(A,1)
% D. Selva 1/28/2015
%
    % Initializations
    paths = java.util.ArrayList;
    cycles = java.util.ArrayList;
    
    % Start with paths of length 2
    N = size(A,1);
    adj=find(A(start,:)>0);%adjacent nodes;
    for i = 1:length(adj)
        pa = java.util.ArrayList;
        pa.add(start);
        pa.add(adj(i));
        paths.add(pa);
    end
    
    % Find paths and cycles of all lengths until there aren't any left
    path_length=2;
    while path_length<=N
        new_paths = java.util.ArrayList;
        for p = 1:paths.size
            path = paths.get(p-1);% next path
            last = path.get(path.size-1);%last node of path
            adj_p = find(A(last,:)>0);%adjacents of last node
            for k = 1:length(adj_p)
                ad = adj_p(k);
                ppa=java.util.ArrayList;
                ppa.addAll(path);
                ppa.add(ad);% tentative path
                if ad == start%% back to start, this is a cycle!
                    cycles.add(ppa);
%                     disp(['Found new cycle ' char(ppa.toString)]);
                else
                    if ~path.contains(ad) % cannot repeat node
                        new_paths.add(ppa);% add new path to paths
                    end
                end
            end
        end
        paths=new_paths;% at this point, we are done with cycles of length path_length, and go to path_length+1
        path_length=path_length+1;
    end
end