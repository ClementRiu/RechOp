# Donnees du probleme

param e;
param h;
param p;
param n_mat{i in 1..3};
param n;
param t{i in 1..3, j in 1..3};

param f_max := 3600 / (n - 1);


# Variable T_{i,j} : vaut 1 si le ieme train à partir est du type j (j = 1 pour Eurostar, 2 pour HGV et 3 pour PAX)
var T{1..n, 1..3} binary;

# Variable D_{i,j} : date de départ du ieme train, s'il est de type j. 0 sinon.
var D{1..n, 1..3};

# Variable E_{i,j} : 1 si T_{i,1} = T_{j,1} = 1 (les trains aux dates i et j sont des eurostars) et D_{j,1} - D_{i,1} = 30
var E{1..n, 1..n} binary;

# Variable S_{i} : 1 si le train qui part à la date i est un eurostar et que celui-ci est dans la première demi-heure (donc si l'eurostar associé part après), 0 sinon
var S{1..n} binary;

# Valeur de la flexibilite
var f_value;

# Fonction objectif
maximize f: f_value;

subject to

# Un seul type de train par horaire
type_train {i in 1..n } : sum {j in 1..3} T[i,j] <= 1;

# On envoie le bon nombre de train par type et par heure :
nombre_eurostar {j in 1..3} : sum {i in 1..n} T[i, j] = n_mat[j];

# On force D à être nulle là où T est nulle et sinon à être entre 1 et 3600 secondes.
horaires_trains_inf {i in 1..n, j in 1..3} : T[i, j] <= D[i, j];
horaires_trains_sup {i in 1..n, j in 1..3} : D[i, j] <= T[i, j] * 3600;


# On force un train à partir suffisemment longtemps après un autre train, si les trains ij et kl existe bien.
ecart_train_normal {i in 1..(n-1), j in 1..3, k in (i+1)..n, l in 1..3} : D[k, l] - D[i, j] >= t[j, l] + f_value - (3600 + 480 + f_max) * ((1 - T[i, j]) + (1 - T[k, l]));
ecart_train_modulo {i in 2..n, j in 1..3, k in 1..(i-1), l in 1..3} : D[k, l] - (D[i, j] - 3600) >= t[j, l] + f_value - (3600 + 480 + f_max) * ((1 - T[i, j]) + (1 - T[k, l]));

# On verifie qu'il y a un et un seul eurostar associé à chaque eurostar.
eurostar_apres {i in 1..n} : sum {j in (i+1)..n} E[i, j] = S[i];
eurostar_avant {i in 1..n} : sum {j in 1..(i-1)} E[j, i] = T[i, 1] - S[i];

# On vérifie que i et j sont dans le bonne ordre (on regarde bien si les eurostar partent une demi heure après)
eurostar_ordre {i in 1..n, j in 1..i} : E[i, j] = 0;

# On rajoute enfin la contrainte sur la demi-heure
demi_heure_inf {i in 1..n-1, j in (i+1)..n} : - 5400 * (1 - E[i, j])  <= D[j, 1] - D[i, 1] - 1800;
demi_heure_sup {i in 1..n-1, j in (i+1)..n} : D[j, 1] - D[i, 1] - 1800 <= 1800 * (1 - E[i, j]);

printf "---Debut de la resolution ---\n";
solve;
printf "---Fin de la resolution ---\n";
printf "Grille horaire (D) :\n";
for {j in 1..3} {
    printf "   ";
    for {i in 1..n} {
         printf " %d ", D[i, j];
    }
    printf "\n";
}
printf "Grille horaire (T) :\n";
for {j in 1..3} {
    printf "   ";
    for {i in 1..n} {
         printf " %d ", T[i, j];
    }
    printf "\n";
}
printf "Grille horaire (E) :\n";
for {j in 1..n} {
    printf "   ";
    for {i in 1..n} {
         printf " %d ", E[i, j];
    }
    printf "\n";
}
printf "-----------------------------\n   ";

printf "Flexibilite optimale (f) : %d\n", f_value;
end;
