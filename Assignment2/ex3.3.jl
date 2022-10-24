# I/O packages
using MAT
# Linear algebra packages
using SymRCM, SparseArrays, LinearAlgebra
# Plot and graphs packages
using Plots, Graphs, GraphPlot, Cairo, Fontconfig, PrettyTables


# Read file
file = matread("Assignment2/housegraph.mat");
# Extract adjacency matrix
A = file["A"]
authors = file["name"];

x = vec(sum(A, dims = 1))

i = sortperm(x, rev = true)

header =(["Degree Centrality" "member[i]" "idx"  ], ["x" "authors"  "i" ])
data = [x[i] authors[i] i ]
pretty_table(data; header = header, header_crayon = crayon"bold green")
