clear all;
clear java;
A=rand(7,7)>0.5;
for i = 1:size(A,1)
    A(i,i)=0;
end

% A corner case in which brute-force algorith does not find any cycle but
% depth-first algorithm does
% load('A_corner_case.mat')
load('large_matrix.mat')

tic;
bfs = enum_cycles_bfs(A,1);
toc;
tic;
dpf = enum_cycles_dpf(A,1);
toc;
for indx = 1:dpf.size()
    aCycle = java.util.ArrayList;
%     aCycle.add(1);
    aCycle.addAll(dpf.get(indx-1));
%     aCycle.add(1);
    if(~bfs.contains(aCycle))
        disp(['Found different cycle: ' char(aCycle.toString)])
    end
end