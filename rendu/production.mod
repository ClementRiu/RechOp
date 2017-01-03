# Donnees du probleme

param T;
param N;
param Q;
param R;
param stock_ini{i in 1..R};
param c{i in 1..R};
param d{r in 1..R, i in 1..T};

# x: x(i,r) = quantite de la reference r produite pendant la semaine i
var x{1..T, 1..R};

# a: a(i,r) = 1 si la reference r est produite la semaine i, et 0 sinon
var a{1..T, 1..R} binary;

# s: s(i,r) = stock de la reference r en fin de semaine i
var s{0..T, 1..R};

# Fonction objectif
minimize f: sum {i in 1..T, r in 1..R} c[r]*s[i,r];

subject to

# Contraintes
stock_initial {r in 1..R}: s[0,r] = stock_ini[r];

stock {i in 1..T, r in 1..R} : s[i,r] = s[i-1,r] + x[i,r] - d[r,i];

quantite_produite_hebdomadaire {i in 1..T} : sum {r in 1..R} x[i,r] <= Q;

nombre_references {i in 1..T} : sum {r in 1..R} a[i,r] <= N;

decision_production {r in 1..R, i in 1..T} : x[i,r] <= Q*a[i,r];

production_positive {r in 1..R, i in 1..T} : x[i,r] >= 0;
stocks_positifs {r in 1..R, i in 1..T} : s[i,r] >= 0;


# Affichage
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

printf "cout total : %d\n", f;
end;
