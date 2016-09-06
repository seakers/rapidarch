function archs = enum_random_archs_parallel(sets1,part_N,assig_N,n)
% This function shows how to enumerate n random architectures of the
% following parallel ADG
% Decision 1: Standard form given by alternative sets sets1
% Decision 2: Partitioning of N2 elements
% Decision 3: Assignments of N3 elements onto N4 elements

rand_d1 = Enum_random_standardform(sets1,n);
rand_d2 = Enum_random_partition(part_N,n);
rand_d3 = Enum_random_assignment(assig_N,n);

rand_k = Enum_random_standardform([n n n],n);
archs=zeros(n,length(sets1)+part_N+prod(assig_N));
for i = 1:n
    archs(i,:) = [rand_d1(rand_k(i,1),:) rand_d2(rand_k(i,2),:) rand_d3(rand_k(i,3),:)];
end