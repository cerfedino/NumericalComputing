# I/O packages
using MAT
# Linear algebra packages
using SymRCM, SparseArrays, LinearAlgebra
# Plot and graphs packages
using Plots, Graphs, GraphPlot, Cairo, Fontconfig, PrettyTables

# Read file
file = matread("Assignment2/A_SymPosDef.mat");
# Extract adjacency matrix
A = file["A_SymPosDef"]


# Visualize original Matrix
spy(A)

# Permute A using the reverse Cuthill-McKee algorithm
p = symrcm(A)
B = A[p,p]
spy(B)

# Visualize permuted matrix
spy(B)
# Compute Cholesky factor
L = cholesky(A).L
# Visualize Cholesky factor
graphplot(L, names=1:size(L,1), nodefillc=:lightblue, nodelabel=1:size(L,1), nodefontsize=8, nodesize=0.1, edgewidth=0.1)
# Compute Cholesky factor of permuted matrix
L_perm = cholesky(A_perm).L
# Visualize Cholesky factor of permuted matrix
graphplot(L_perm, names=1:size(L_perm,1), nodefillc=:lightblue, nodelabel=1:size(L_perm,1), nodefontsize=8, nodesize=0.1, edgewidth=0.1)

# Compute number of nonzeros
nnz(A)
nnz(A_perm)
nnz(L)
nnz(L_perm)
