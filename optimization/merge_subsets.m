function merged = merge_subsets(orig,s1,s2)
    merged = orig;
    subset1 = orig{s1};
    subset2 = orig{s2};
    merged{min(s1,s2)} = unique([subset1 subset2]);
    merged{max(s1,s2)} = [];
    merged(cellfun(@isempty,merged)) = [];
end