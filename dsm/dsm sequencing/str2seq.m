function seq = str2seq(str,params)
    seq = cell2mat(cellfun(@(x)find(strcmp(params.LABELS,x)),str,'UniformOutput',false));
end