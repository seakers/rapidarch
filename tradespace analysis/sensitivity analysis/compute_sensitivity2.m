function S = compute_sensitivity2(decs, metric, opt)
% compute sensitivity.
    S = 0;
    Nopt = length(opt);
    for o = 1:Nopt
        indexes = (decs == opt(o));
        main_effect = mean(metric(indexes)) - mean(metric(~indexes));% main effect of decision d = option o
        if ~isnan(main_effect)
            S = S + abs(main_effect);
        end
    end
    S = S/Nopt;
end