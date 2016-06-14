function archs = Enum_una_relations(N,directed,self_connections)
    if directed && self_connections %% tested OK
        vecarchs = Enum_binary_arrays(N*N);
        n = 2^(N*N);
        archs = cell(n,1);
        for i = 1:length(vecarchs)
            archs{i} = reshape(vecarchs(i,:),[N N]);
        end 
    elseif directed && ~self_connections %% tested OK
        vecarchs = Enum_binary_arrays(N*N);
        n = 1;
        archs = cell(n,1);
        for i = 1:length(vecarchs)
            tmp = reshape(vecarchs(i,:),[N N]);
            invalid = false;
            for j = 1:N
                if tmp(j,j) >0 % Self connection
                    invalid = true;
                end
            end
            if ~invalid
                archs{n} = tmp;
                n = n+ 1;
            end
        end 
        archs(n:end) = [];
        
    elseif ~directed && self_connections % tested OK
        vecarchs = Enum_binary_arrays(nchoosek(N,2)+N);
        n = 2^(nchoosek(N,2)+N);
        archs = cell(n,1);
        for i = 1:length(vecarchs)
            tmp = triu(ones(N),1);
            indexes = logical(tmp + eye(N));
            tmp(indexes) = vecarchs(i,:);
            archs{i} = tmp + tmp';
            archs{i}(archs{i}==2) = 1;
        end 
    else % ~directed && ~self_connections, tested OK
        vecarchs = Enum_binary_arrays(nchoosek(N,2));
        n = 2^(nchoosek(N,2));
        archs = cell(n,1);
        for i = 1:length(vecarchs)
            tmp = triu(ones(N),1);
            tmp(tmp>0) = vecarchs(i,:);
            archs{i} = tmp + tmp'+ eye(N);
        end  
    end
    
end