function [ cluster_matrix ] = PACK_cluster_matrix( x)
%PACK_cluster_matrix Computes element-to-cluster assignment matrix based on vector representation
%of a partition
%   Usage: PACK_cluster_matrix([1,1,2,1,3,2,4,2])
N = length(x);
cluster_matrix = zeros(max(x),N);
for i = 1:N
    cluster_matrix(x(i),i)=1;
end

end

