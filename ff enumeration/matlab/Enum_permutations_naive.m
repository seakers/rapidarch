%Enum_permutations_naive.m
function archs = Enum_permutations_naive(N)
    Architectures = {};
    if N == 0
        return;
    end
    Architectures{1} = [1];
    Architectures{2} = [1 2;2 1];
    for i = 3:N
        n = 1;
        for a = 1:size(Architectures{i-1},1)
            arch = Architectures{i-1}(a,:);
            mx = length(arch) + 1;
            for j = 1:mx
                if j == 1
                    Architectures{i}(n,:) = cat(2,mx,arch(j:end));
                elseif j == mx
                    Architectures{i}(n,:) = cat(2,arch(1:j-1),mx);
                else
                    Architectures{i}(n,:) = cat(2,arch(1:j-1),mx,arch(j:end));
                end               
                n = n + 1;
            end
        end
    end
    archs = Architectures{N};
end