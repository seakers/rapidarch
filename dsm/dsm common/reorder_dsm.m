function new_dsm = reorder_dsm(dsm,pos)
%  comments by Nozomi Hitomi 09/16/2015
%This function takes an existing DSM and a new desired sequencing or
%ordering of columns and rows, and outputs a new DSM with the desired order.
%
%Inputs:
%DSM is a n x n matrix with n functions, processes, or components. Any
%element along the diagonal of dsm will be ignored. 
%pos a n x 1 vector with the desired sequence or order of functions, 
%processes, or components
%
%Outputs:
% new_dsm is a new dsm with the desired sequence or order of functions, 
%processes, or components

    N = size(dsm,1);
    new_dsm = zeros(N);
    for i = 1:N
        for j = 1:N
            if i~=j
                new_dsm(i,j) = dsm(pos(i),pos(j));
            end
        end
    end
end
