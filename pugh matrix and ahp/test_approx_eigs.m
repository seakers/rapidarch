%% test_approx_eigs.m
N=1000;
DIM=3;
a12v=randi(DIM,1,N);
a23v=randi(DIM,1,N);
a13v=randi(DIM,1,N);
EPSILON=1e-5;
true_eigs = cell(1,N);
approx_eigs = cell(1,N);
diff = zeros(1,N);
counter=0;
flag = zeros(1,N);
for i = 1:N
    a12=a12v(i);
    a23=a23v(i);
    a13 = a12*a23; % uncomment this line for consistent matrix
%     a13=a13v(i); % uncomment this line for inconsistent matrix
    
    A = [1 a12 a13;1/a12 1 a23;1/a13 1/a23 1];
    [n,~]=size(A);

    % True eigenvector
    [V,D]=eigs(A);
    true_eigs{i} = V(:,1)./sum(V(:,1));

    % approx eigenvector
    A2=A./repmat(sum(A,1),[n 1]);
    approx_eigs{i} = mean(A2,2);

    % compare
    diff(i) = norm(true_eigs{i} - approx_eigs{i});
   
end
hist(diff);
