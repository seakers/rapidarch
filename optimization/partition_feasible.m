function feas = partition_feasible(part)
    if part(1) ~= 1
        feas=false;
        return;
    end
    maxs = 1;
    for i = 2:length(part)
        elem = part(i);
        if  elem <= 0 || elem > 1+maxs
            feas=false;
            return;
        else
            maxs = max(maxs,elem);
        end
    end
    feas = true;
end
    