function cm = rand_comp_mat2(n)
% cm = rand_comp_mat(n)
% this function generates a random reciprocal comparison matrix of size n
% inputs: n (size)
% outputs: cm, an n x n reciprocal comparison matrix
% Note that the random generation is done in a slightly different way than in
% rand_comp_mat.m (this one is more representative)
%
% Daniel Selva <ds925@cornell.edu>
% 9/3/15
%

% This is really the difference with respect to the other version. Instead
% of generating random matrices of integers between 1 and 9 and then
% setting some values to ensure the matrix is reciprocal, we generate
% random sequences of integer numbers that we use to index the vector of
% all possible values 1/9,1/8,...,1,2,...,9

values = [1/9 1/8 1/7 1/6 1/5 1/4 1/3 1/2 1 2 3 4 5 6 7 8 9];
L = length(values);
cm = values(randi(L,[n n])); % generate random matrix of integers from 1 to 9

% The rest is identical
% set a_ii = 1 \forall i
for i = 1:n
    cm(i,i) = 1;
end

% set a_ij = 1/a_ji for all i,j
for i = 2:n
    for j = 1:i-1
        cm(i,j) = 1/cm(j,i);
    end
end
