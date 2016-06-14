function xoverKids  = crossover_partition(parents,options,GenomeLength,FitnessFcn,unused,thisPopulation)

% How many children to produce?
nKids = length(parents)/2;
% Extract information about linear constraints, if any
linCon = options.LinearConstr;
constr = ~isequal(linCon.type,'unconstrained');
% Allocate space for the kids
xoverKids = zeros(nKids,GenomeLength);

% To move through the parents twice as fast as thekids are
% being produced, a separate index for the parents is needed
index = 1;
% for each kid...
for i=1:nKids
    % get parents
    parent1 = thisPopulation(parents(index),:);
    index = index + 1;

    parent2 = thisPopulation(parents(index),:);
    index = index + 1;

    %% BEGIN CUSTOM PART: Compute children from 2 partitions
    xoverKids(i,:) = cross_part2(parent1,parent2);
    
    %% END CUSTOM PART: Make sure that offspring are feasible w.r.t. linear constraints
    if constr
        feasible  = isTrialFeasible(xoverKids(i,:)',linCon.Aineq,linCon.bineq,linCon.Aeq, ...
            linCon.beq,linCon.lb,linCon.ub,sqrt(options.TolCon));
        if ~feasible % Kid is not feasible
            % Children are arithmetic mean of two parents (feasible w.r.t
            % linear constraints)
            alpha = rand;
            xoverKids(i,:) = round(alpha*thisPopulation(r1,:) + ...
                (1-alpha)*thisPopulation(r2,:));
        end
    end
end

end