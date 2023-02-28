# I/O packages
using MAT
# Linear algebra packages
using SymRCM, SparseArrays, LinearAlgebra
# Plot and graphs packages
using Plots, Graphs, GraphPlot, Cairo, Fontconfig, PrettyTables

# Read file
file = matread("./A_SymPosDef.mat");
# Extract adjacency matrix
A = file["A_SymPosDef"]


# Visualize original Matrix
# spy(A)

# Permute A using the reverse Cuthill-McKee algorithm
p = symrcm(A)
A_permuted = A[p,p]

# Visualize permuted matrix
# spy(A_permuted)


# Compute Cholesky factor
L = cholesky(A).L

# spy(sparse(L))

L_permuted = cholesky(A_permuted).L

# spy(sparse(L_permuted))

# plot everything in one figure to file
plot(spy(A), spy(A_permuted), spy(sparse(L)), spy(sparse(L_permuted)), layout=(2, 2))

# Compute number of nonzeros
nnz(A)
nnz(A_permuted)
nnz(sparse(L))
nnz(sparse(L_permuted))
