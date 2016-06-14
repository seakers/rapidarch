function fitness = my_fitness_function2(bits)
if bits(2) == 0 && bits(3) == 0
    fitness = [1e5 1e5];
else
    arch = bitstring2arch(bits);
    [cost,reliab] = evaluate(arch);
    fitness = [cost -reliab];
end
    
end