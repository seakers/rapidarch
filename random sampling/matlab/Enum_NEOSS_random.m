function Architectures = Enum_NEOSS_random(N,p)
    Architectures = {};
    n = 1;
    for d = 1:2^N-1
        instr_sel = de2bi(d,N); % instrument selection
        NI = sum(instr_sel);
        part_archs = Enum_partition_naive(NI);% instrument packaging
        for part = 1:length(part_archs)
            NS = max(part_archs(part,:));
            perm_archs = Enum_permutations_naive(NS);
            for perm = 1:length(perm_archs)
                if rand<p
                    Architectures{n} = {instr_sel part_archs(part,:) perm_archs(perm,:)};
                    n = n + 1;
                end
            end
        end        
    end
end