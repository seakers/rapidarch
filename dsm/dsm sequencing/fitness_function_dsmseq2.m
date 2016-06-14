function penalties = fitness_function_dsmseq2(x,params)
    dsm = params.CONNECTIVITIES;
    new_dsm = reorder_dsm(dsm,x);
    penalties = sum(sum(tril(new_dsm)));
end