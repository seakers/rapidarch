function Architectures = Enum_binary_arrays(N)
    Narch = 2^N; % N is the number of binary decisions
    Architectures = zeros(Narch,N);% each architecture is a row in this matrix
    for d = 0:2^N - 1
        % Use de2bi to transforms the decimal value d into a binary vector of length N
        Architectures(d+1,:) = de2bi(d,N,'right-msb');
    end
end
	