function TEP = impulsion(K, N, d0, d1, trellis, s_i, closed, iSNR)
    R = K/N;
    v = zeros(1, K);
    x_u = zeros(1, K);
    y = ones(1, N);
    for l=1:K
        A = d0-0.5;
        x_u_bis = x_u;
        while all(x_u_bis == x_u) && A<=d1
            A = A+1;
            y(l) = 1-A;
            x_u_bis = viterbi_decode(y, trellis, s_i, closed);
        end
        v(l) = floor(A);
    end
    
    [Ad, D] = groupcounts(v');
    
    TEP = 0;
    
    for i=1:length(D)
        TEP = TEP + 0.5*Ad(i)*erfc(sqrt(D(i)*R*iSNR));
    end
    
    if TEP>1
        TEP = 1;
    end
end