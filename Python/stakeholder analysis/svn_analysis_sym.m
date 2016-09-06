function [sh_scores_sym] = svn_analysis_sym(A, sh_names, central)
% [scores,ranked_sh] = svn_analysis_sym(A, sh_names, central)
% This function performs a stakeholder value network analysis as proposed
% in Cameron, B., “Value flow mapping: Using networks to inform stakeholder analysis,” 
% Acta Astronautica, vol. 62, Feb. 2008, pp. 324–333.
%
% Added symbolic capabilities to deal with unknown variables 
% indicating value flows. 
% In this case the variables must be declared as syms and the A matrix must
% contain these syms
% Example: 
% syms alpha_c alpha_sg
% A = [0 0.5 0.8 0 0 0;alpha_c 0 0 0 0 0;0.5 0 0 0.8 0 0;0 0 0 0 alpha_sg 0.3;0.5 0.3 0.3 0 0 0.3;0 0 0 0 0.8 0]
% A is a square matrix representing the value flows between pairs of
% stakeholders. A(i,i) =0 \forall i
% sh_names is a cell of strings with the names of the stakeholders
% including the central stakeholder. 
% central is a string containing the name of the central stakeholder
%
% Example: 
% sh_names = {'project','customer1','customer2','scientists','government','public'}
% central = 'project'
%
% The function performs the following steps:
% Compute all cycles starting and ending with 'central' stakeholder
% Compute the scores of all these cycles
% Compute importance of stakeholder i as the sum of the scores of all cycles
% that start and end with 'start' and go through stakeholder i
%
% Returns sh_scores_sym as a function of variables indicating value flows. 
% Note that the current version computes the scores but does not solve the system of inequalities
% that would be required to rank the stakeholders as a function of the
% variable value flows.%
% D. Selva <ds925@cornell.edu>
% 9/2/15
% 

%% Find all cycles symbolically

vars = symvar(A);
for i = 1:length(vars)
    eval([char(vars(i)) ' = 0.0001;']);%any value greater than 0 in order to find cycles correctly
end

A_simpl = eval(A);
for i = 1:length(vars)
    clear(char(vars(i)));
    syms(char(vars(i)));
end

start = find(strcmp(sh_names,central));
cycles = enum_cycles_dpf(A_simpl,start);
ncycles = cycles.size;

%% Compute cycle scores symbolically
cycle_scores_sym = sym('cycle_scores2',[ncycles 1]);
for i = 1:ncycles
    cycle_scores_sym(i) = 1;
end
for i = 1:ncycles
    cycle = cycles.get(i-1);
    st = cycle.get(0);
    for j = 1:cycle.size-1
        en = cycle.get(j);
        cycle_scores_sym(i) = eval(cycle_scores_sym(i))*A(st,en);
        st = en;
    end
end
total_score_sym = sum(cycle_scores_sym);

%% Compute stakeholder importance scores symbolically
nsh = size(A,1);
sh_scores_sym = sym('sh_scores_sym',[nsh 1]);
for i = 1:nsh
    sh_scores_sym(i) = 0;
end
for i = 1:nsh
    for j = 1:ncycles
        cycle = cycles.get(j-1);
        if cycle.contains(i)
            sh_scores_sym(i) = sh_scores_sym(i) + cycle_scores_sym(j);
        end
    end
end
sh_scores_sym = sh_scores_sym./total_score_sym;% note normalization is not needed to compare the relative importance of stakeholders
sh_scores_sym = simplify(sh_scores_sym);% should get 1 on score of central stakeholder.

end