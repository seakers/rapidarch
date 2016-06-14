%% classification_trees.m
% Example of regression tree;
load carsmall; % contains Horsepower, Weight, MPG
X = [Horsepower Weight];
rtree = fitrtree(X,MPG);
view(rtree);
view(rtree,'mode','graph');

% Example of classification tree;
load ionosphere % contains X and Y variables
ctree = fitctree(X,Y);
view(ctree);
view(ctree,'mode','graph');