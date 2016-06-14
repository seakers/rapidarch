function mutationChildren = PACK_mutation2(parents,options,GenomeLength,FitnessFcn,state,thisScore,thisPopulation,scale,shrink)
% PACK_mutation2.m
% 4 different possible mutations that occur with equal probability:
% a) one random instrument gets moved into a different random satellite
% b) a random large satellite gets broken into two by a random place
% c) two small random satellites get combined
% d) two random instruments exchange position
% 
% Daniel Selva, Oct 1st 2011

mutationChildren = zeros(length(parents),GenomeLength);
for i=1:length(parents)
    parent = thisPopulation(parents(i),:);
%     parent = thisPopulation{parents(i),:};
    new_ind = parent;
%     mutated = false;



    %Single instrument
    pos = randi(length(new_ind));% instrument position to change
    old = new_ind(pos);
    new = old;
    while new==old
        new = randi(max(new_ind)+1);% can go to any previous sat or a new one
    end
    new_ind(pos) = new;

    new_ind = PACK_fix(new_ind);
%     if ~isequal(PACK_fix(parent),new_ind)
%         mutated = true;
%     end
    mutationChildren(i,:) = new_ind;
end

