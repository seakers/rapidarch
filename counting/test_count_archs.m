%% test_count_archs.m
% Provides some test uses of the function count_archs
problem1.type = 'SUBSET-SELECTION';
problem1.parameters.N = 10;
n1 = count_archs(problem1);

problem2.type = 'PARTITIONING';
problem2.parameters.N = 10;
n2 = count_archs(problem2);

problem3.type = 'PERMUTING';
problem3.parameters.N = 10;
n3 = count_archs(problem3);

problem4.type = 'ASSIGNING';
problem4.parameters.N = 5;
problem4.parameters.M = 3;
n4 = count_archs(problem4);

problem5.type = 'CONNECTING';
problem5.parameters.N = 5;
problem5.parameters.self_connections = false;
problem5.parameters.directed = true;
n5 = count_archs(problem5);

problem6.type = 'DISJOINT-SELECTION';
problem6.parameters.alternative_sets = {{'A','B','C'},{'yessss','no'},[1,2,3,4]};
n6 = count_archs(problem6);