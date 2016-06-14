function fitness = my_fitness_function(bits)
    arch = bitstring2arch(bits);
    [cost,reliab] = evaluate(arch);
    fitness = [cost -reliab];
end