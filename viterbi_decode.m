function u = viterbi_decode(y, trellis, s_i, closed)
    mat_poids = 1000*ones(trellis.numStates, length(y)/2+1); %matrice contenant les métriques
    mat_states = 1000*ones(trellis.numStates, length(y)/2+1); %matrice contenant les états parents
    mat_u = 1000*ones(trellis.numStates, length(y)/2+1); %matrice contenant les bits outputs
    poids = 0; 
    mat_poids(s_i+1, 1) = poids;
    for i=1:length(y)/2
        for j=1:trellis.numStates %chaque ligne de la matrice poids correspond à un état (ligne 1=état 1, ligne 2=état2...)
            if mat_poids(j, i) ~= 1000
                state = j;
                %cas 0 en entrée
                bin0 = de2bi_perso(trellis.outputs(state, 1));
                poids0 = mat_poids(j, i) + bin0(1)*y(2*i-1)+bin0(2)*y(2*i); %on calcule le poids avec 0 en entrée
                if poids0 < mat_poids(trellis.nextStates(state, 1)+1, i+1) %si le poids est bien inférieur au poids déjà présent dans la cellule
                    mat_poids(trellis.nextStates(state, 1)+1, i+1) = poids0; %on met à jour la matrice des poids
                    mat_states(trellis.nextStates(state, 1)+1, i+1) = state; %on met à jour la matrice des états
                    mat_u(trellis.nextStates(state, 1)+1, i+1) = 0; %on met 0 dans la matrice des u
                end
                %cas 1 en entrée
                bin1 = de2bi_perso(trellis.outputs(state, 2));
                poids1 = mat_poids(j,i) + bin1(1)*y(2*i-1)+bin1(2)*y(2*i); %on calcule le poids avec 1 en entrée
                if poids1 < mat_poids(trellis.nextStates(state, 2)+1, i+1) %si le poids est bien inférieur au poids déjà présent dans la cellule
                    mat_poids(trellis.nextStates(state, 2)+1, i+1) = poids1; %on met à jour la matrice des poids
                    mat_states(trellis.nextStates(state, 2)+1, i+1) = state; %on met à jour la matrices états
                    mat_u(trellis.nextStates(state, 2)+1, i+1) = 1; %on met 1 dans la matrice des u
                end
            end
        end
    end
    
    %on récupère le minimum du poids dans la dernière colonne
    [M, I] = min(mat_poids(:, length(y)/2+1));
    u = zeros(1, length(y)/2);
    %on remonte la matrice des u dans le sens inverse
    for j=length(y)/2+1:-1:2
        u(j-1) = mat_u(I, j);
        I = mat_states(I, j);
    end
    
    if(closed == 1)
        q = log2(trellis.numStates);
        u = u(1:length(u)-q);
    end
end