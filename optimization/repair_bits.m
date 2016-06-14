function bits = repair_bits(bits)
%% repair_bits 
% This function repairs an architecture expressed as a bit string in the
% test tradespace example. More precisely, if the architecture has the
% forbidden combination 00 for bits 2 and 3, it randomly selects one of the
% three valid combinations with equal probabilities.
    
    if bits(2) == 0 && bits(3) == 0
        u = rand;
        if u<1/3
            bits(2) = 1;
        elseif u<2/3
            bits(3) = 1;
        else
            bits(2) = 1;
            bits(3) = 1;
        end
    end
end