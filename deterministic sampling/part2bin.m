function bin = part2bin(part)
% This function transforms a partition expressed as a vector of N integers
% respecting the restrcited growth constraint into a binary vector of
% length nchoosek(N,2) where each bit represents whether or not a pair
% elements is present
% bin = part2bin(part)

N = length(part);
l = nchoosek(N,2);
bin = zeros(1,l);
n = 1;
for i = 1:N-1
    for j = i+1:N
        if part(i) == part(j)
            bin(n) = 1;
        end
        n = n + 1;
    end
end
