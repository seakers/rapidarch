function [sh_scores_sorted,ranked_sh] = svn_analysis(A, sh_names, central)
% [scores,ranked_sh] = svn_analysis(A)
% This function performs a stakeholder value network analysis as proposed
% in Cameron, B., “Value flow mapping: Using networks to inform stakeholder analysis,” 
% Acta Astronautica, vol. 62, Feb. 2008, pp. 324–333.
%
% A is a square matrix representing the value flows between pairs of
% stakeholders. A(i,i) =0 \forall i
% sh_names is a cell of strings with the names of the stakeholders
% including the central stakeholder. 
% central is a string containing the name of the central stakeholder
% Example: 
% sh_names = {'project','customer1','customer2','scientists','government','public'}
% central = 'project'
%
% The function performs the following steps:
% Compute all cycles starting and ending with 'start'
% Compute the scores of all these cycles
% Compute importance of stakeholder i as the sum of the scores of all cycles
% that start and end with 'start' and go through stakeholder i
% Return stakeholder names sorted by stakeholder importance
%

% Find all cycles
start = find(strcmp(sh_names,central));
cycles = enum_cycles_dpf(A>0,start);
ncycles = cycles.size;

% Compute cycle scores
cycle_scores = ones(ncycles,1);

for i = 1:ncycles
    cycle = cycles.get(i-1);
    st = cycle.get(0);
    for j = 1:cycle.size-1
        en = cycle.get(j);
        cycle_scores(i) = cycle_scores(i)*A(st,en);
        st = en;
    end
end
total_score = sum(cycle_scores);

% Compute stakeholder importance scores
nsh = size(A,1);
sh_scores = zeros(nsh,1);
for i = 1:nsh
    for j = 1:ncycles
        cycle = cycles.get(j-1);
        if cycle.contains(i)
            sh_scores(i) = sh_scores(i) + cycle_scores(j);
        end
    end
end
sh_scores = sh_scores./total_score;

% Rank stakeholders according to importance scores
[sh_scores_sorted,ranked_sh] = sort(sh_scores,'descend');

% Get rid of central stakeholder
sh_scores_sorted = sh_scores_sorted(2:end);
ranked_sh = sh_names(ranked_sh(2:end));
end