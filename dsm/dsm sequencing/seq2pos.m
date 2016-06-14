function pos = seq2pos(seq)
    pos = zeros(1,length(seq));
    for i = 1:length(seq)
        pos(i)=find(seq==i,1);
    end
end


