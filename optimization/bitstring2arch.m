function arch = bitstring2arch(bits)
    % bitstring2arch This function transforms a binary sequence into its
    % corresponding architecture
    % Input: bits = bitstring of length Nvars
    % Output: arch = integer vector of length Ndecisions
    % Usage: arch = bitstring2arch([0 1 1 0])
    % Assumption: Left-most bit (bit 1) corresponds to 1st decision, bits 2
    % and 3 correspond to the 2nd decision, and bit 4 corresponds to the
    % 3rd decision. For the 2nd decision, the combination 00 is forbidden
    % and must be repaired (e.g. assign randomly one of the valid
    % combinations). 
    % 
    bits = logical(bits);
    arch(1) = bits(1) + 1;% map from [0,1] to [1,2]
    arch(2) = bi2de(bits(2:3));% map from {00,01,10,11} to [0,1,2,3] (0 is forbidden)
    arch(3) = bits(4) + 1;% map from [0,1] to [1,2]
end