function penalties = fitness_function_dsmseq_vectorized(pop,params)
    narc = size(pop,1);
    penalties = zeros(narc,1);
    for a = 1:narc
        x = pop{a};
        penalties(a) = fitness_function_dsmseq2(x,params);
    end
end