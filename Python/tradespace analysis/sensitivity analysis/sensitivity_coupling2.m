function [S, C, CN] = sensitivity_coupling2(archs, metrics)
% SENSITIVITY_COUPLING Computes the sensitivity and coupling of each decision in each metric as presented in class 
% INPUTS:
% - archs: a matrix of size Narch x Ndec, with as many rows as architectures
% and as many columns as decisions
% - metrics: a matrix of size Narch x Nmet, with as many rows as
% architectures and as many columns as metrics
% 
% OUTPUTS:
% S: a Ndec x Nmet matrix containing the sensitivity of each metric to
% each decision
% C: a Ndec x Ndec x Nmet matrix containing the couplings between each pair
% of decisions through each metric
% CN: a Ndec x Nmet matrix containing the connectivity of each decision
% in each metric
%
% EXAMPLE: 
% archs = fullfact([2 4 3]);
% metrics = rand([24 3]);
% [S,C,CN] = sensitivity_coupling2(archs, metrics)

% Init
[~, Ndec] = size(archs);
[~, Nmet] = size(metrics);
S = zeros(Ndec, Nmet);% sensitivity of decision i in metric j
C = zeros(Ndec, Ndec, Nmet);% coupling between decisions i and j through metric k
CN = zeros(Ndec, Nmet); % connectivity of decision i in metric j

%Loop
for m = 1:Nmet
    for d = 1:Ndec
        opt = unique(archs(:,d));
        S(d, m) = compute_sensitivity2(archs(:,d), metrics(:,m), opt);
        for d2 = 1:Ndec
            if d==d2
                continue;
            end
            opt2 = unique(archs(:,d2));
            C(d, d2, m) = compute_coupling2(archs(:,d), archs(:,d2), metrics(:,m), opt, opt2);
            CN(d, m) = CN(d, m) + C(d, d2, m);
        end
        CN(d, m) = CN(d, m)/(Ndec - 1);
    end
end

end

