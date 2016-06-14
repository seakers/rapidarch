function Architectures = Enum_parallel_example(N1,N2,N3)
    ds_archs = Enum_binary_arrays(N1);
    pa_archs = Enum_partition_naive(N2);
    pe_archs = Enum_permutations_naive(N3);
    Narc = prod([length(ds_archs) length(pa_archs) length(pe_archs)]);
    Architectures = zeros(Narc,N1+N2+N3);
    n = 1;
    for i = 1:length(ds_archs)
        for j = 1:length(pa_archs)
            for k = 1:length(pe_archs)
                Architectures(n,:) = [ds_archs(i,:) pa_archs(j,:) pe_archs(k,:)];
                n = n + 1;
            end
        end        
    end
end