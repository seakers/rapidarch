function archs = Enum_bin_relations(N,M)
    vecarchs = Enum_binary_arrays(N*M);
    n = 2^(N*M);
    archs = cell(n,1);
    for i = 1:length(vecarchs)
        archs{i} = reshape(vecarchs(i,:),[N M]);
    end  
end