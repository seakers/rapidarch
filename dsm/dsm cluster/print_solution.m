function print_solution(x)
    disp(x);
    cellfun(@(x)disp(num2str(x)),PACK_arch2sats(x),'UniformOutput',false);
    c = cell(1,length(x));
    for i = 1:length(x)
        c{i} = ['E' num2str(i)];
    end
%     graph_matrix(x, 'Elx', 'Ely', 'Title', c, c, 0, x)
end