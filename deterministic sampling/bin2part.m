function part = bin2part(bin)
% This function transforms a partition expressed as a binary vector of
% length nchoosek(N,2) where each bit indicates whether or not a pair of 
% elements are together into an integer vector of length N representing the
% same partition in the restricted growth formulation.
% part = bin2part(bin)
l = length(bin);
N = 0.5*(1+sqrt(1+8*l));
part = 1:N;
i = 1;
j = 2;
for n = 1:l
    % Set two subsets of elements equal
    if bin(n) == 1
        part(j) = part(i);
    end
    % Update indexes
    j = j + 1;
    if j>N
        j = i + 2;
        i = i + 1;
    end
end
part = PACK_fix(part);% Renumber
