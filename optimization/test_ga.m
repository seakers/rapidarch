%% test_ga.m
Nopt = [2 3 2];
Ndec = length(Nopt);
nbit = ceil(log2(Nopt));% Number of bits needed to encode the architectures
nvars = sum(nbit);% Chromosome length

options = gaoptimset('PopulationSize',50,'PopulationType','bitString','Generations',100);
options = gaoptimset(options, 'CreationFcn',@my_creation_fcn,'MutationFcn',@my_mutation_fcn,'CrossoverFcn',@my_crossover_fcn);
options = gaoptimset(options,'Display','iter','PlotFcns',{@gaplotpareto});
[x,fval,exitflag,output,population] = gamultiobj(@my_fitness_function2,nvars,[],[],[],[],[],[],options);



%% Plots
narch = size(population,1);
final_metrics = zeros(narch,2);
final_archs = zeros(narch,Ndec);
for i = 1:narch
    final_archs(i,:) = bitstring2arch(population(i,:));
    [final_metrics(i,1),final_metrics(i,2)] = evaluate(final_archs(i,:));
end
front = paretofront([final_metrics(:,1),-final_metrics(:,2)]);
front_archs = final_archs(front,:);
front_metrics = final_metrics(front,:);
close;
plot_tradespace(final_archs,final_metrics);

