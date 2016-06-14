function arch = subsets2partition(subsets)
% subsets2partition.m
% Example: 
% sats{1} = [1,2,3,7];
% sats{2} = [4,5,6,8];
% sats{3} = [9];
% arch = subsets2partition(sats)
% arch = [1,1,1,2,2,2,1,2,3]

nsubsets = length(subsets);
nel = sum(cellfun(@length,subsets));
arch = zeros(1,nel);
for i = 1:nsubsets
    subset = subsets{i};
    arch(subset) = i;
end
end