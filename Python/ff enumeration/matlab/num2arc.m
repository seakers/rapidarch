function arc = num2arc(sets,a)
    n = length(sets);
    arc = cell(1,n);
    for i = 1:n
        arc{i} = sets{i}{a(i)+1};
    end
end