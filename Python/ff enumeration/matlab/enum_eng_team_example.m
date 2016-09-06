function Archs = enum_eng_team_example(N1,N2)
%This example is for assigning engineers to certain projects. Given N1
%engineers and N2 projects, you downselect which engineers should be
%considered for assignment, downselect which projects to pursue, and then
%assign the selected engineers to the selected projects.

ds_engs = Enum_binary_arrays(N1);
ds_proj = Enum_binary_arrays(N2);

Archs = {}; 
n=1;
for i=1:length(ds_engs)
    n_engs = sum(ds_engs(i,:)); %find the number of engineers selected
    for j=1:length(ds_proj)
        n_projs = sum(ds_proj(j,:)); %find the number of projects selected
        assn_set = n_engs*n_projs;
        if assn_set ==0 %if there are 0 engineers or 0 projects, not feasible
            continue;
        else
            assignment = Enum_binary_arrays(n_engs*n_projs); %assign
            for k=1:size(assignment,1)
                Archs{n} = [ds_engs(i,:),ds_proj(j,:),assignment(k,:)];
                n=n+1;
            end
        end
    end
end
        
