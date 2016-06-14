function subsets = partition2subsets(varargin)
% partition2subsets.m
% Example: 
% sats = partition2subsets([1,1,1,2,2,2,1,2,3])
% sats{1} = [1,2,3,7];
% sats{2} = [4,5,6,8];
% sats{3} = [9];

arch = varargin{1};
if nargin > 1
    offset = varargin{2};
else
    offset = 0;
end

nsubsets = max(arch);
subsets = cell(nsubsets,1);
for i = 1:nsubsets
    subsets{i} = find(arch==i) + offset;
end
end