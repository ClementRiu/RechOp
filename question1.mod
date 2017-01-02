# Donnees du probleme

param T;
param N;
param Q;
param R;
param stock_ini{i in 1..R};
param c{i in 1..R};
param d{r in 1..R, i in 1..T};

# Variable x_{i,r} : quantite de la reference r produite pendant la semaine i
var x{1..T, 1..R};

# Variable p_{i,r} : vaut 1 si la reference r est produite la semaine i 0 sinon
var p{1..T, 1..R} binary;

# Stock s_{i,r} de la reference r en fin de semaine i
var s{0..T, 1..R};

# Fonction objectif
minimize f: sum {i in 1..T, r in 1..R} c[r]*s[i,r];

subject to

# Stock initial en fin de la premiere semaine
stock_initial {r in 1..R}: s[0,r] = stock_ini[r];

# Modification du stock par la production et la demande
evolution_stock {i in 1..T, r in 1..R} : s[i,r] = s[i-1,r] + x[i,r] - d[r,i];

# Limite de production hebdomadaire
quantite_produite {i in 1..T} : sum {r in 1..R} x[i,r] <= Q;

# Limite de reference productibles
nombre_references {i in 1..T} : sum {r in 1..R} p[i,r] <= N;

# Decisions de production
decision_production {r in 1..R, i in 1..T} : x[i,r] <= Q*p[i,r];

# Positivite des termes
production_positive {r in 1..R, i in 1..T} : x[i,r] >= 0;
stocks_positifs {r in 1..R, i in 1..T} : s[i,r] >= 0;

printf "---Debut de la resolution ---\n";
solve;
printf "---Fin de la resolution ---\n";
printf "Production (x) :\n";
for {r in 1..R} {
    printf "   ";
    for {i in 1..T} {
         printf " %d ", x[i,r];
    }
    printf "\n";
}
printf "-----------------------------\n   ";
for {i in 1..T} {
    printf " %d ", sum {r in 1..R} x[i,r];
}
printf "\n";
printf "Demande (d) :\n";
for {r in 1..R} {
    printf "   ";
    for {i in 1..T} {
         printf " %d ", d[r,i];
    }
    printf "\n";
}
printf "Stocks (s) :\n";
for {r in 1..R} {
    for {i in 0..T} {
         printf " %d ", s[i,r];
    }
    printf "\n";
}
printf "Decision de production (p) :\n";
for {r in 1..R} {
    printf "   ";
    for {i in 1..T} {
         printf " %d ", p[i,r];
    }
    printf "\n";
}
printf "c total (p) : %d\n", f;
end;
