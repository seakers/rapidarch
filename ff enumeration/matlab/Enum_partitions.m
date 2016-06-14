% Enum_partition.m
function Architectures = Enum_partitions(N)
    Architectures = [];
    Architectures(:,1) = [1;1];
    Architectures(:,2) = [1;2];
    for i = 3:N
        arch3 = [];
        for a = 1:size(Architectures,2)
            arch = Architectures(:,a);
            mx = max(arch) + 1;
            arch2 = arch;
            for j = 1:mx-1
                arch2 = cat(2,arch2,arch);
            end
            arch2(i,:) = 1:mx;
            arch3 = [arch3,arch2];
        end
        Architectures = arch3;
    end
end