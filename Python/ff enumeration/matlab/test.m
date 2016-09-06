n = 10000;
X = zero(2,1);
Y = zeros(n,1);
for i=1:n
    X(1) = randn(1)+5;
    X(2) = randn(1)*5;
    Y(i) = runSimulation(X);
end