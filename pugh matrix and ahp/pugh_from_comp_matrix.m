function scores = pugh_from_comp_matrix(comp_matrices,weights,ref)
% This function performs Pugh matrix analysis given a set of comparison matrices and
% a set of weights and a reference alternative ref. 
% Daniel Selva <ds925@cornell.edu>
% 9/3/15
%
ncrit = length(weights);
nalt = size(comp_matrices{1},1);
plus_minuses = zeros(ncrit,nalt);
for i = 1:ncrit
    for j = 1:nalt
        if comp_matrices{i}(j,ref) > 1
            plus_minuses(i,j) = 1;
        elseif comp_matrices{i}(j,ref) < 1
            plus_minuses(i,j) = -1;
        else
            plus_minuses(i,j) = 0;
        end
    end
end

scores = plus_minuses'*weights;
