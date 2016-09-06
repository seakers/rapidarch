function normalized_metrics = normalize(metrics,types,mode)
% This function normalized a matrix of metrics where each row contains the
% metrics for an architecture.
% Inputs: Metrics is a Narch x Nmetric matrix
% types is a Nmetric cell array where each entry is set to 'LIB' or 'SIB'
% depending on whether the metric is Large Is Better or Small Is Better.
% mode sets whether the normalized metrics are LIB or SIB 
% Example of usage: metrics = normalize([cost perf],{'SIB','LIB'},'LIB')
% 
[Narch,Nmet] = size(metrics);
normalized_metrics = zeros(Narch,Nmet);
for i = 1:Nmet
    if strcmp(types{i},'LIB')
        normalized_metrics(:,i) = normalize_LIB(metrics(:,i));
    elseif strcmp(types{i},'SIB')
        normalized_metrics(:,i) = normalize_SIB(metrics(:,i));
    else
        error('Unsupported type of metric: only SIB or LIB supported.')
    end
end
if strcmp(mode,'SIB')
    normalized_metrics = 1 - normalized_metrics;
end
end

function norm = normalize_LIB(metric)
if max(metric) ~= min(metric)
    norm =(metric - min(metric))./(max(metric)- min(metric)); 
else
    norm = metric./min(metric);
end

end

function norm = normalize_SIB(metric)
if max(metric) ~= min(metric)
    norm =(max(metric) - metric)./(max(metric)- min(metric));
else
    norm = metric./max(metric);
end
end