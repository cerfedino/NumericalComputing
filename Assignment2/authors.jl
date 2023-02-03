using MAT, SparseArrays
using Plots
using SymRCM
using Graphs, GraphPlot, Cairo, Fontconfig, Compose

include("drawit.jl")

# Read housegraph.mat
file = matread("Assignment2/housegraph.mat");

# Get author names
name = file["name"];

# Get adjacency matrix
A = file["A"];

# Compute sparsity
sparsity = nnz(A)/prod(size(A));

# Plot adj. matrix
spy(A)

# Find most cited author index m
m = findmax(sum(A, dims=1))[2][2];

# Compute the Reverse Cuthill-McKee node permutation from a sparse matrix
p = symrcm(A);

# Draw using drawit(A, m, name)
drawit(A, m, name, "authors.png")



# -------------------------------
# reorder the authors
r = symrcm(A[2:end, 2:end]);
prcm = vcat(1, r .+ 1);
spy(A[prcm, prcm])
drawit(A[prcm, prcm], m, name, "authors_reorder.png")
