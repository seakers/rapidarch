function Architectures = Enum_random_binary2(N,Narch,p)
    random_u = rand([Narch N]);
    Architectures = random_u<p;
end
	