function n = count_archs(problem)
%function n = count_archs(problem)
%
% Counts the number of architectures in a given architecture problem. 
% problem is a structure with the following fields: 'type' and 'parameters'
% The following combinations of types and parameters are allowed:
%
% type = 'SUBSET-SELECTION': This is a binary selection problem over a set
% of elements of size given by problem.parameters.N
%
% type = 'DISJOINT-SELECTION': This is a disjoint selection problem given
% by a number of decisions, each with its own sets of alternatives. The 
% alternative sets are given in problem.parameters.alternative_sets as a
% cell array of cell arrays
% 
% type = 'PARTITIONING': This is a set partitioning problem over a set
% of elements of size given by problem.parameters.N
% 
% type = 'ASSIGNMENT': This is an assignment problem over two sets of
% elements of sizes given by problem.parameters.N and problem.parameters.M
% 
% type = 'CONNECTING': This is a connecting problem over a set
% of elements of size given by parameters.N. The problem can be directed 
% or undirected as controlled by the boolean problem.parameters.directed
% and self-connections may or may not be allowed as controlled by boolean
% parameter problem.parameters.self_connections
% 
% type = 'PERMUTING': This is a permuting problem over a set
% of elements of size given by problem.parameters.N
% 
% Author: Daniel Selva <ds925@cornell.edu> 8/17/2015

switch problem.type
    case 'SUBSET-SELECTION'
        N = problem.parameters.N;
        n = 2^N;
    case 'PARTITIONING'
        N = problem.parameters.N;
        n = Bell(N);
    case 'ASSIGNING'
        N = problem.parameters.N;
        M = problem.parameters.M;
        n = 2^(N*M);
    case 'CONNECTING'
        N = problem.parameters.N;
        if problem.parameters.self_connections
            m = 1;% self connections allowed
        else
            m = 0;% not allowed
        end
        if problem.parameters.directed
            k = 1;% directed graph
        else
            k = 2;% undirected graph
        end
        n = 2^(N*(N-1)/k+m*N);
    case 'PERMUTING'
        N = problem.parameters.N;
        n = factorial(N);
    case 'DISJOINT-SELECTION'
        Ni = cellfun(@length,problem.parameters.alternative_sets);
        n = prod(Ni);
    otherwise
        error('Unsupported decision type');
end
