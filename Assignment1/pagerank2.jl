#   M.L. for Numerical Computing @USI - malik.lechekhab@usi.ch 

using MAT, SparseArrays
using LinearAlgebra, Plots
using PrettyTables

file = matread("Assignment1/datasets/ETH500.mat");
G = file["G"];
U = file["U"];

function pagerank2(U, G)

    p = .85;
    precision = 1e-16;

    n = size(G)[2];

    # out-degree
    c = vec(sum(G, dims=1));
    # in-degree
    r = vec(sum(G, dims=2));

    k = findall(!iszero, c);
    D = sparse(k, k, map(x -> 1/x, c[k]), n, n);

    e = ones(n, 1);

    # Ex 5.2 Inverse iteration method
    z = ((1- p) * map(!iszero, c) + map(iszero, c)) / n;
    z = reshape(z, (1,n));
    
    x = e / n;
    A = p * G * D + e * z;
    alpha = 0.99;

    prev_x = zeros(n);
    it = 0;
    while any(x->abs(x)>=precision, prev_x-x)
        prev_x = x;
        x = (alpha * I - A) \ x;
        x = x / sum(x);
        it += 1;
    end

    # Print results
    #   Print number of iterations
    println("Number of iterations: ", it);
    #   Print table
    i = sortperm(vec(x), rev = true);
    header =(["index" "page-rank" "in" "out" "url"], ["i" "x" "r" "c" "U"])
    data = [i x[i] r[i] c[i] U[i]]
    pretty_table(data; header = header, header_crayon = crayon"bold green")

    bar(x, lab="page ranking")
end

x = pagerank2(U, G)