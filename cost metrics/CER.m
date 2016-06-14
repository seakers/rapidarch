%% CER.m
close all;
clear all;
%% 2D
C_0 = 100;
beta_vec = [0.5 0.8 0.95 1.05 1.2 2];
x = 0:0.01:1;
f = figure;
ax = axes('Parent',f,'FontSize',18);
colors = {'b','r','g','k','m','y'};
for i = 1:length(beta_vec)
    beta = beta_vec(i);
    C = C_0.*x.^beta;
    plot(x,C,'color',colors{i});
    hold on;
end
xlabel('x');
ylabel('Cost');
grid on;
legend(cellfun(@(x)['\beta = ' num2str(x)],num2cell(beta_vec),'UniformOutput',false),'Location','Best');

%% 3D
clear all;
close all;
C_0 = 100;
% beta1_vec = [0.5 0.8 1.2];
% beta2_vec = [0.5 0.8 1.2];
beta1_vec = [0.5];
beta2_vec = [0.8];
x1 = 0:0.01:1;
x2 = 0:0.01:1;
[X1,X2] = meshgrid(x1,x2);
f = figure;
ax = axes('Parent',f,'FontSize',18);
bb = linspace(0,1,length(beta1_vec)*length(beta2_vec));
rr = 1 - bb;
for i = 1:length(beta1_vec)
    for j = 1:length(beta2_vec)
        index = (i-1)*length(beta2_vec)+j;
        beta1 = beta1_vec(i);
        beta2 = beta2_vec(j);
        C = C_0.*X1.^beta1.*X2.^beta2;
%         surf(X1,X2,C,'color',[rr(index),0,bb(index)]);
        surf(X1,X2,C,'FaceLighting','phong');
%         hold on;
    end
end
xlabel('x_1/x_1ref');
ylabel('x_2/x_2ref');
zlabel('Cost');
grid on;
[xx,yy] = meshgrid(beta1_vec,beta2_vec);
% daspect([1,1,.3]);axis tight;

% Set up recording parameters (optional), and record
OptionZ.FrameRate=15;OptionZ.Duration=10;OptionZ.Periodic=false;
CaptureFigVid([-20,10;-110,10;-190,80;-290,10;-380,10], 'Video3D',OptionZ)
% legend(cellfun(@(x,y)['\beta_1 = ' num2str(x) ',\beta_2 = ' num2str(y) ],num2cell(xx(:)),num2cell(yy(:)),'UniformOutput',false),'Location','Best');