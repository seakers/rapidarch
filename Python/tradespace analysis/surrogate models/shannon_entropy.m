function h = shannon_entropy(p)
    if sum(p) == 0
        error('At least 1 entry must be non-zero');
    end
    if sum(p) ~= 1
        p = p./sum(p);% Normalize
    end
    p = p(p>0);% Get rid of null entries to avoid numerical problems, we know that 0*log2(0)=0
    h = sum(-p.*log2(p));
end