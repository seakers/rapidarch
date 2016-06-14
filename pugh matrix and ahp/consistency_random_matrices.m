%% consistency_random_matrices.m
vecn = 3:8;
NIT = 500;
N = length(vecn);
cons = zeros(N,NIT);
for i = 1:length(vecn) % for different values of the dimension of the matrix
    n = vecn(i);
    for j = 1:NIT % try multiple times
        cm = rand_comp_mat2(n);% generate random comparison matrix
        cons(i,j) = consistency_index(cm);% compute consistency index
    end
end
avg_cons = mean(cons,2);%take average of NIT values for each n