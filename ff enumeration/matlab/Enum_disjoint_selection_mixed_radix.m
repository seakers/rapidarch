function archs = Enum_disjoint_selection_mixed_radix(alternative_sets)
% function archs = Enum_disjoint_selection_mixed_radix(alternative_sets)
% This function generates all architectures for a standard form decision
% problem using a mixed-radix generation approach.
%
% Example of usage:
% sets = {{'A','B','C'},{'0','1'},{'yes','no'}}
% archs = Enum_disjoint_selection_mixed_radix(sets)
% D. Selva <ds925@cornell.edu>
%
    bases = cellfun(@length,alternative_sets);% count how many alternatives per decision
    c = 0;
    overflow = false;
    ndec = length(bases);
    narchs = prod(bases);% numner of architectures is the product
    arch = zeros(1,ndec);
    archs = cell(narchs,ndec);
    while(~overflow)
        archs(c+1,:) = num2arc(alternative_sets,arch);%from [0 0 0] to actual options
        [arch,overflow] = add1(arch,bases);% add 1, next arch
        c =c + 1;
    end
end

