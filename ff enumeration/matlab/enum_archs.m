function archs = enum_archs(problem)
%function archs = enum_archs(problem)
%
% Generates all architectures in a given architecture problem. 
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
        archs = Enum_binary_arrays(problem.parameters.N);
    case 'PARTITIONING'
        archs = Enum_partitions(problem.parameters.N);
    case 'ASSIGNING';
        archs = Enum_bin_relations(problem.parameters.N,problem.parameters.M);
    case 'CONNECTING'
        archs = Enum_una_relations(problem.parameters.N,problem.parameters.directed,problem.parameters.self_connections);
    case 'PERMUTING'
        archs = Enum_permutations_naive(problem.parameters.N);
    case 'DISJOINT-SELECTION'
        archs = Enum_disjoint_selection(problem.parameters.alternative_sets);
    otherwise
        error('Unsupported decision type');
end
