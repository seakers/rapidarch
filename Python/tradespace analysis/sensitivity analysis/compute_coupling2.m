function C = compute_coupling2(decs1, decs2, metric, opt1, opt2)
    C = 0;
    Nopt2 = length(opt2);
    for o = 1:Nopt2
        indexes = (decs2 == opt2(o));
        inter_effect = compute_sensitivity2(decs1(indexes), metric(indexes), opt1) - compute_sensitivity2(decs1(~indexes), metric(~indexes), opt1);
        C = C + abs(inter_effect);
    end
    C = C/Nopt2;
end