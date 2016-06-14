function [scores,consistencies] = ahp(criteria_cm,alternative_cms)
% scores = ahp(A)
% This function computes the scores given when applying the Analytic
% Hierarchy Process to the decision problem defined by a comparison matrix
% with the pairwise comparisons between the criteria, and a number of
% comparison matrices for the pairwise comparisons between the
% alternatives, namely one for each criterion
%
% Inputs:
% criteria_cm is an m x m reciprocal matrix, where m is the number of criteria
% alternative_cms is a cell array of m n x n reciprocal matrices, where n
% is the number of alternatives
%
% It is desirable that these matrices all be consistent, i.e. that
% a_ij*a_jk = a_ik for all i,j,k
% 
% Outputs:
% scores is a vector of size n containing the priorities of each
% alternative
% consistencies is a vector of size m containing the consistency of the
% decision maker for each of the criteria
% 
% For details on AHP, see for example: 
% 1 Saaty, T. L., “Decision Making With the Analytic Hierarchy Process,” International Journal of Services Sciences, vol. 1, 2008, pp. 83–98.
% 
% Daniel Selva <ds925@cornell.edu>
% 9/3/15
%
N_alt = size(alternative_cms{1},1);
N_crit = size(criteria_cm,1);
[V, ~] = eigs(criteria_cm);
priorities_criteria = V(:,1)./sum(V(:,1));
priorities_alter = zeros(N_crit,N_alt);
consistencies = zeros(N_crit + 1,1);
consistencies(1) = consistency_index(criteria_cm);
for i = 1:N_crit
    [V, D] = eigs(alternative_cms{i});
    priorities_alter(i,:) =  V(:,1)'./sum(V(:,1));
    consistencies(i) = consistency_index(alternative_cms{i});
end
scores = priorities_alter'*priorities_criteria;


