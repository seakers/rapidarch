function mutationChildren = my_mutation_fcn(parents,options,GenomeLength,FitnessFcn,state,thisScore,thisPopulation,mutationRate)
% Adapted from MATLAB's MUTATIONUNIFORM Uniform multi-point mutation.

if nargin < 8 || isempty(mutationRate)
    mutationRate = 0.01; % default mutation rate
end

mutationChildren = zeros(length(parents),GenomeLength);
for i=1:length(parents)
    child = thisPopulation(parents(i),:);
    mutationPoints = find(rand(1,length(child)) < mutationRate);
    child(mutationPoints) = ~child(mutationPoints);
    mutationChildren(i,:) = repair_bits(child);
%      mutationChildren(i,:) = child;
end
    
end
