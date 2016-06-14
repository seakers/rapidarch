%% cost_spread.m
close all;
clear all;

S = 0:0.01:1;
A1 = 0.32;
B1 = 0.68;
F1 = A1*(10 + S.*((15-4.*S).*S-20)).*S.^2 + B1*(10 + S.*(6.*S - 15)).*S.^3 + (1-(A1+B1)).*(5-4.*S).*S.^4;
A2 = 0.96;
B2 = 0.04;
F2 = A2*(10 + S.*((15-4.*S).*S-20)).*S.^2 + B2*(10 + S.*(6.*S - 15)).*S.^3 + (1-(A2+B2)).*(5-4*S).*S.^4;
f = figure;
ax = axes('Parent',f,'FontSize',18);
plot(100*S,100*F1,'b',100*S,100*F2,'r');
xlabel('S(%)');
ylabel('F(%)');
grid on;


f = figure;
ax = axes('Parent',f,'FontSize',18);
plot(100*S,[0 100*diff(F1)],'b',100*S,[0 100*diff(F2)],'r');
xlabel('S(%)');
ylabel('dF/dS');
grid on;
