using MAT, SparseArrays

using PrettyTables

include("pagerank.jl")

# Read housegraph.mat
file = matread("./housegraph.mat");

# Get author names
authors = file["name"];

# Get adjacency matrix
A = file["A"];

# Compute rank
x, c, r = page_rank(authors, A, 0.85);


i = sortperm(x, rev = true);
header =(["index" "page-rank" "in" "out" "author"], ["i" "x" "r" "c" "authors"])
data = [i x[i] r[i] c[i] authors[i]]
pretty_table(data; header = header, header_crayon = crayon"bold green")

bar(x, lab="page ranking")

# print top 10 authors
println("Top 10 authors: ", authors[i[1:10]])
