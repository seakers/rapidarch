function archs = mixed_radix(bases)
    %Inputs: bases is a vector of bases to use (e.g. bases = [5,2,3]. This
    %corresponds to 3 decisions with 5, 2, and 3 options for each
    %respective decision.)
    
    c = 0;
    overflow = false;
    ndec = length(bases);
    narchs = prod(bases);
    arch = zeros(1,ndec);
    archs = zeros(narchs,ndec);
    while(~overflow)
        archs(c+1,:) = arch;
        [arch,overflow] = add1(arch,bases);
        c =c + 1;
    end
end