function test
archs = 1:100;
science = rand(100,1);
cost = randn(100,1)+20;

h=plot(science,cost,'o');
set(gca,'ButtonDownFcn', {@example_interactive_plot,archs,science,cost});
end