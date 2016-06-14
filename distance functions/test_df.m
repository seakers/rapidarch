N = 10;
archs = zeros(2^N,N);
metrics = zeros(2^N,3);
k = 1:10;
w1 = 10.^[-(k-1)/3];
w2 = 10.^[-(N-k)/3];

for d = 0:2^N - 1
    archs(d+1,:) = de2bi(d,N);
    metrics(d+1,1) = sum(archs(d+1,:).*w1); 
    metrics(d+1,2) = sum(archs(d+1,:).*w2);
    metrics(d+1,3) = 10 - sum(archs(d+1,:)); 
end

front = paretofront(metrics);
sum(front)
