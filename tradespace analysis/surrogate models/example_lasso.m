%% example_lasso.m

X = randn(100,5);
r = [0.1;2;0.1;-3;0];  
Y = X*r + randn(100,1)*.1; % Y is approximately equal to 2x_2 - 3x_4 plus some noise
fitlm(X,Y)% linear model gives non-zero entries for all coefficients
[B,fitinfo] = lasso(X,Y,'LambdaRatio',0:0.1:3) % lasso sets entries to zero
