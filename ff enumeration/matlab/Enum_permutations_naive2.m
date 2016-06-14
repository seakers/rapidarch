% Enum_permutations_naive2.m
function ret = Enum_permutations_naive2(N)
    Architectures = cell(N,1);
    Architectures{1} = (1:N)';
    for i = 2:N
        archs = Architectures{i-1};% [1;2;3;4]
        n=1;
        k=size(archs,1);
        new_archs = zeros(k*(N-i+1),i);
        for a = 1:length(archs)
            arc=archs(a,:);%1
            remaining = setdiff(1:N,arc);
            for j = 1:length(remaining)
                new_archs(n,:) = [arc remaining(j)];
                n=n+1;
            end
        end
        Architectures{i} = new_archs;
    end
    ret = Architectures{N};
end