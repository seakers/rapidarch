function Population = my_creation_fcn(GenomeLength,FitnessFcn,options)
    totalPopulation = sum(options.PopulationSize);
    initPopProvided = size(options.InitialPopulation,1);
    individualsToCreate = totalPopulation - initPopProvided;
    
    % Initialize Population to be created
    Population = ones(totalPopulation,GenomeLength);
    % Use initial population provided already
    if initPopProvided > 0
        Population(1:initPopProvided,:) = options.InitialPopulation;
    end
    % Create remaining population
    Population(initPopProvided+1:end,:) = double(0.5 > rand(individualsToCreate,GenomeLength));
    for i = 1:length(Population)
        Population(i,:) = repair_bits(Population(i,:));
    end
end