function distances = compute_distances_to_pf(metrics)
    distances = zeros(size(metrics,1),1);
    front = paretofront(metrics);
    front_metrics = metrics(front,:);
    for i = 1:size(metrics,1)
        [min_d,~] = min(sqrt(sum((front_metrics - repmat(metrics(i,:),[size(front_metrics,1) 1])).^2,2)));
        distances(i) = min_d;
    end
end