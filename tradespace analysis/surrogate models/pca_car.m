load carbig;
indexes = ~isnan(MPG) & ~isnan(Weight) & ~isnan(Acceleration) & ~ isnan(Horsepower);
Weight2 = Weight(indexes);
Acceleration2 = Acceleration(indexes);
MPG2 = MPG(indexes);
Horsepower2 = Horsepower(indexes);
Model2 = Model(indexes,:);

X = zscore([MPG2 Acceleration2 Weight2 Horsepower2]);
[coeff, score, latent, tsquared, explained] = pca(X);

scatter(score(:,1),score(:,2));

N = hist(MPG);
pemp_MPG = N./sum(N);
shannon_entropy(pemp_MPG);
