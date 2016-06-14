%% test_enum_archs.m
% Provides some test uses of the function enum_archs
problem1.type = 'SUBSET-SELECTION';
problem1.parameters.N = 5;
archs1 = enum_archs(problem1);

problem2.type = 'PARTITIONING';
problem2.parameters.N = 5;
archs2 = enum_archs(problem2);

problem3.type = 'PERMUTING';
problem3.parameters.N = 5;
archs3 = enum_archs(problem3);

problem4.type = 'ASSIGNING';
problem4.parameters.N = 2;
problem4.parameters.M = 3;
archs4 = enum_archs(problem4);

problem5.type = 'CONNECTING';
problem5.parameters.N = 3;
problem5.parameters.self_connections = false;
problem5.parameters.directed = true;
archs5 = enum_archs(problem5);

problem6.type = 'DISJOINT-SELECTION';
problem6.parameters.alternative_sets = {{'A','B','C'},{'yessss','no'},[1,2,3,4]};
archs6 = enum_archs(problem6);