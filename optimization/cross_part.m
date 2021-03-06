function xoverKid = cross_part(parent1,parent2)
    GenomeLength = length(parent1);
    kk = ceil(GenomeLength/2);
    first_half = parent1(1:kk);
    first_half_parent1 = partition2subsets(first_half);%these are subsets corresponding to first half of chromosome
    nsubset1 = length(first_half_parent1);

    second_half =  parent2(kk+1:end);
    second_half_parent2 = partition2subsets(repair_partition(second_half),kk);%these are subsets corresponding to second half of chromosome
    
   % Try to combine subsets of second half with subset of first half
    kid_subset = [first_half_parent1;second_half_parent2];
    xoverKid = subsets2partition(kid_subset);
    if partition_feasible(xoverKid)
        return;
    end
    
    % If it doesn't work, try to project
    existing_subset = parent2(kk+1:end) <= max(parent2(1:kk)); %existing_subset = 1 means that element i is in a subset that was created in the first half
    nsubset2 = length(second_half_parent2);
  
 
    for j = 1:nsubset2 % foreach subset from mum
        subset = second_half_parent2{j}; % subset
        for k = 1:length(subset) % loop through its elements
            elem = subset(k);% element
            if existing_subset(elem-kk) % if this element in mum belongs to a subset of the 1st half
                % lump this subset with a random subset from first half
                % (which comes from dad)
                kid_subset = merge_subsets(kid_subset,randi(nsubset1),j+nsubset1);% merge subset random and this one
                break;% go to next subset in loop over j
            end
        end
    end    

    xoverKid = subsets2partition(kid_subset);
end