%% inverse_transform_sampling.m
close all;
clear all;

x = -4:0.01:4;
% y = zeros(size(x));
% for i = 1:length(x)
%     y(i) = ;
% end
y = normcdf(x,0,1);
figure;
axes('Parent',gcf,'FontSize',18);
plot(x,y,'b-');
hold on;
plot([-4 0.6746],[0.75 0.75],'r-');
plot([0.6746 0.6746],[0 0.75],'r-');

xlabel('x');
ylabel('cdf(x)');
grid on;


