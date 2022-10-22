# I/O packages
using MAT
# Linear algebra packages
using SymRCM, SparseArrays, LinearAlgebra
# Plot and graphs packages
using Plots, Graphs, GraphPlot, Cairo, Fontconfig, PrettyTables

# Read file
file = matread("A_SymPosDef.mat");
# Extract adjacency matrix
A = file["A_SymPosDef"]
# ...

