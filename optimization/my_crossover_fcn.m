function xoverKids  = my_crossover_fcn(parents,options,GenomeLength,FitnessFcn,unused,thisPopulation)
% ADAPTED FROM MATLAB'S FUNCTION. 

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

for i=1:nKids
    % get parents
    parent1 = thisPopulation(parents(index),:);
    index = index + 1;
    parent2 = thisPopulation(parents(index),:);
    index = index + 1;

    % cut point is AFTER this index.
    xOverPoint = ceil(rand * (length(parent1) - 1));
    % make one child
    xoverKids(i,:) = [ parent1(1:xOverPoint),parent2(( xOverPoint + 1 ):  end )  ];
    % Make sure that offspring are feasible w.r.t. linear constraints
    if constr
        feasible  = isTrialFeasible(xoverKids(i,:)',linCon.Aineq,linCon.bineq,linCon.Aeq, ...
        linCon.beq,linCon.lb,linCon.ub,sqrt(options.TolCon));
        if ~feasible % Kid is not feasible
            % Children are arithmetic mean of two parents (feasible w.r.t
            % linear constraints)
            alpha = rand;
            xoverKids(i,:) = alpha*parent1 + (1-alpha)*parent2;
        end
    end
    xoverKids(i,:) = repair_bits(xoverKids(i,:));
end