%Enum_random_permutations.m
function Architectures = Enum_random_permutations(N, Narch)
    Architectures = zeros(Narch,N);
    for i = 1:Narch
        arch = zeros(1,N);%preallocate for efficiency
        for j = 1:N
            remaining = setdiff(1:N,arch);
            arch(j)=remaining(randi(length(remaining)));
        end
        Architectures(i,:) = arch;
    end
end