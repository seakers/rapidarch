function [a,overflow] = add1(a,levels)
    k=length(levels);%start with least significant digit
    overflow = false;
    while(k>0) % iterate while there are digits left
        a(k) = a(k) + 1;% add 1
        if (a(k) == levels(k)) % if digit is saturated
            if k==1 % if last digit
                overflow = true;% overflow
                a = [];
                return;
            else % otherwise carry the 1 to next digit
                a(k) = 0;
                k = k - 1;
            end
        else % if digit is not saturated end
            break;
        end
    end 
end