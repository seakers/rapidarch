function [P]=paretofront2(X)
%Author Nozomi Hitomi
%Created 11/17/2015
%This code implements the first part of the fast nondominated sorting from 
%NSGA-II. Assumes minimization of all objectives
%Input: X is a nxm matrix with m objectives and n solutions
%Ouput: P is the nx1 logical vector with true if the solution lies in the
%Pareto front

a=size(X,1);
domination_counter=zeros(a,1);
for i=1:a
    for j=i+1:a
        dom = dominates(X(i,:),X(j,:));
        if dom==-1
            domination_counter(j) = domination_counter(j) + 1;
        elseif dom==1
            domination_counter(i) = domination_counter(i) + 1;
        end
    end
end

P = find(domination_counter==0);
end

function dom = dominates(soln1,soln2)
%This function returns -1 if soln1 dominates soln2, 1 if soln2 dominates
%soln1, 0 if neither dominates the other. Each solution should be a vector
%of objectives. Assumes minimization in all objectives
ndec = length(soln1);
dominate = zeros(ndec,1);
for i=1:ndec
    if soln1(i) < soln2(i)
        dominate(i) = -1;
    elseif soln1(i) > soln2(i)
        dominate(i) = 1;
    end
end

if isempty(find(dominate==-1,1)) && ~isempty(find(dominate==1,1))
    dom = 1;
elseif ~isempty(find(dominate==-1,1)) && isempty(find(dominate==1,1))
    dom = -1;
else
    dom = 0;
end
end