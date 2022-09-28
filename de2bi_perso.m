function bin = de2bi_perso(dec)
    tmp = zeros(1, 2);
    if dec==0
        tmp(1) = 0;
        tmp(2) = 0;
    elseif dec==1
        tmp(1) = 0;
        tmp(2) = 1;
    elseif dec==2
        tmp(1) = 1;
        tmp(2) = 0;
    elseif dec==3
        tmp(1) = 1;
        tmp(2) = 1;
    end
    bin = tmp;
end