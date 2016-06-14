global x
function [cost,reliab] = evaluate(arch)
    cost = eval_cost(arch);
    reliab = eval_reliab(arch);
end
function C = eval_cost(arch)
    C=0;
    if arch(1) == 1
        C = C + 30;
    else
        C = C + 70;
    end
    
    if arch(2) == 1
        C = C + 3;
    elseif arch(2) == 2
        C = C + 10;
    else
    end
    
    if arch(3)==2
        C=2*C;
    end
end
function R = eval_reliab(arch)
    if arch(1) == 1
        R1 = 0.9;
    else
        R1 = 0.99;
    end

    if arch(2) == 1
        R2 = 0.99;
    elseif arch(2) == 2
        R2 = 0.999;
    else
        R2 = 0.5;
    end
    if arch(3)==1
        R=R1*R2;
    else
        R = (R1 + R1 - R1*R1)*(R2 + R2 - R2*R2);
    end
end
