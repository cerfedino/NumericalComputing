#   M.L. for Numerical Computing @USI - malik.lechekhab@usi.ch 

using MAT, SparseArrays
using LinearAlgebra, Plots
using PrettyTables

file = matread("./datasets/ETH500.mat");
G = file["G"];
U = file["U"];

function pagerank1(U, G)

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

    # Ex 5.1 Power method
    G = p * G * D;
    z = ((1- p) * map(!iszero, c) + map(iszero, c)) / n;
    z = reshape(z, (1,n));
    x = e / n;
    
    prev_x = zeros(n);
    it = 0;
    while any(x->abs(x)>=precision, prev_x-x)
        prev_x = x;
        x = G * x + e * (z * x);
        it += 1;
    end

    # normalize
    x = x / sum(x);
    
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

x = pagerank1(U, G)