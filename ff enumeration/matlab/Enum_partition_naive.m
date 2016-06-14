% Enum_partition_naive.m
function archs = Enum_partition_naive(N)
    Architectures = {};
    if N == 0
        return;
    end
    Architectures{1} = [1];
    Architectures{2} = [1 1;1 2];
    for i = 3:N
        n = 1;
        for a = 1:size(Architectures{i-1},1)
            arch = Architectures{i-1}(a,:);
            mx = max(arch) + 1;
            for j = 1:mx
                Architectures{i}(n,:) = cat(2,arch,j);
                n = n + 1;
            end
        end
    end
    archs = Architectures{N};
end