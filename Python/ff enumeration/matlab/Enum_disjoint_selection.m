function archs = Enum_disjoint_selection(alternative_sets)
    levels = cellfun(@length,alternative_sets);
    archs = fullfact(levels);
end
	