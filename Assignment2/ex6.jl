using DelimitedFiles
using SparseArrays
using LinearAlgebra

# read matrix from karate.txt
A = readdlm("Assignment2/karate.txt", Int)

# note that in-degree and out-degree are equal
c = vec(sum(A, dims=1))
r = vec(sum(A, dims=2))



# sort by degree centrality
i = sortperm(c, rev = true);

# print nodes
header =(["member" "in" "out"], ["i" "r" "c"])
data = [i r[i] c[i]]
pretty_table(data; header = header, header_crayon = crayon"bold green")

bar(x, lab="Degree Centrality")


# Rank the five nodes with the largest eigenvector centrality.

