function cm = rand_comp_mat(n)
% cm = rand_comp_mat(n)
% this function generates a random reciprocal comparison matrix of size n
% inputs: n (size)
% outputs: cm, an n x n reciprocal comparison matrix
% Daniel Selva <ds925@cornell.edu>
% 9/3/15
%
cm = randi(9,[n n]); % generate random matrix of integers from 1 to 9

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
