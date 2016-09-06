% Enum_random_partition2.m
function Architectures = Enum_random_partition2(N,Narch)
    Architectures = zeros(Narch,N);
    for i = 1:Narch
        arch = zeros(1,N);%preallocate for efficiency
        arch(1)=1;
        for j = 2:N
            arch(j)=randi(max(arch) + 1);
        end
        Architectures(i,:) = arch;
    end
end