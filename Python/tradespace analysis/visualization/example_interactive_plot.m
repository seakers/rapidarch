function mycallback_function(src,eventdata,archs,sciences,costs)
% mycallback_function: Sensitive tradespace plot. Shows information about architecture when clicking on corresponding point of tradespace 
% inputs src and eventdata must be there even if not used
% inputs archs, sciences and costs are vectors of architectures, performance values, and cost values 
% 
% Example of usage:
% archs = enumerate_archs();% enumerate architectures
% [sciences,costs] = evaluate_archs(archs);% evaluate architectures
%	plot(sciences,costs,'ButtonDownFcn', {@mycallback_function,archs,sciences,costs});
%
	mouse = get(gca, 'CurrentPoint');
	xmouse = mouse(1,1);
	ymouse = mouse(1,2);
	[val, i] = min(abs((sciences - xmouse)/xmouse).^2+abs((costs - ymouse)/ymouse).^2);
	fprintf('Arch # %d = %s, Science = %f, Cost = %f\n',i,binarchtostr(archs(i,:)),sciences(i),costs(i));
end
