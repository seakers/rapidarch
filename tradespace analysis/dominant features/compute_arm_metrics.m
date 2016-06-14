%% compute_arm_metrics.m
function vals = compute_arm_metrics(dataset,G)
    % This function takes a dataset of binary features of which G is the
    % goodness feature and computes support (F), confidence (F-> G), conf (G ->
    % F) and lift (F & G) for all features in the dataset
    % Example: dataset = compute_advanced_features2(gncs);vals = compute_arm_metrics(dataset,'front')
    
    [N,NF] = size(dataset);

    supp = zeros(NF,1);
    confF_G = zeros(NF,1);
    confG_F = zeros(NF,1);
    liftF_G = zeros(NF,1);
    names = dataset.Properties.VariableNames';
    suppG = sum(dataset.(G) == 1)/N;
    for f = 1:NF
        var = names{f};
    %     if strcmp(var,G)
    %         supp
    %         continue;
    %     end
        supp(f) = sum(dataset.(var) == 1)/N;
        confF_G(f) = sum(dataset.(var) == 1 & dataset.(G) == 1)/N/supp(f);
        confG_F(f) = confF_G(f)*supp(f)/suppG;
        liftF_G(f) = confF_G(f)/suppG;
    end
    
    vals = table(names,supp, confF_G, confG_F, liftF_G);
    vals.driving = vals.confF_G > 0.9 | vals.confG_F > 0.9 & vals.liftF_G > 1;
end


    