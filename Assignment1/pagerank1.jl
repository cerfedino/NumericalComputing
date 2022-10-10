#   M.L. for Numerical Computing @USI - malik.lechekhab@usi.ch 

using MAT, SparseArrays
using LinearAlgebra, Plots
using PrettyTables

file = matread("Assignment1/ETH500.mat");
G = file["G"];
U = file["U"];

function pagerank(U, G)

    p = .85;

    n = size(G)[2];

    # out-degree
    c = vec(sum(G, dims=1));
    # in-degree
    r = vec(sum(G, dims=2));

    k = findall(!iszero, c);
    D = sparse(k, k, map(x -> 1/x, c[k]), n, n);

    e = ones(n, 1);
    sI = sparse(I, n, n);



    # Ex 5.1 Power method
   

    # Print results
    #   Print table
    i = sortperm(vec(x), rev = true);
    header =(["index" "page-rank" "in" "out" "url"], ["i" "x" "r" "c" "U"])
    data = [i x[i] r[i] c[i] U[i]]
    pretty_table(data; header = header, header_crayon = crayon"bold green")

    bar(x, lab="page ranking")
end

x = pagerank(U, G)