function Architectures = Enum_random_binary(N,Narch)
    Architectures = zeros(Narch,N);% each architecture is a row in this matrix
    random_ints = randi(2^N,[1 Narch]) - 1;
    for i = 1:Narch
        % Use de2bi to transforms the random integer into a binary vector of length N
        Architectures(i,:) = de2bi(random_ints(i),N,'right-msb');
    end
end
	