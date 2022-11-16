# Cluster 2D real-world graphs with spectral clustering and compare with k-means 
# USI, ICS, Lugano
# Numerical Computing

using SparseArrays, LinearAlgebra, Arpack
using Clustering
using MAT

include("Tools/add_paths.jl");

# Number of clusters
K = 4;

W, pts = read_mat_graph("./Datasets/Meshes/airfoil1.mat");
# W, pts = read_mat_graph("./Datasets/Meshes/barth4.mat");
# W, pts = read_mat_graph("./Datasets/Meshes/3elt.mat");

draw_graph(W, pts)

# Dummy variable
dummy_map = rand(1:K, size(pts, 1));

# 2a) Create the Laplacian matrix and plot the graph
# ----------------------------
#     Your implementation
# ----------------------------

#   Eigen-decomposition
# ----------------------------
#     Your implementation
#     (Hint: use eigsvals() and eigvecs())
# ----------------------------

#   Plot and compare
draw_graph(W, pts)
#   TODO: Plot using eigenvector coordinates



# 2b) Cluster each graph in K = 4 clusters with specatral and k-means method, compare your results visually for each case.

# ----------------------------
#     Your implementation
# ----------------------------

#   Plot and compare
#   TODO: Plot the spectral clusters
draw_graph(W, pts, dummy_map)
#   TODO: Plot the spectral clusters
draw_graph(W, pts, dummy_map)

# 2c) Calculate the number of nodes per clustering
histogram(dummy_map, title = "Dummy histogram", legend = false)
histogram(dummy_map, title = "Dummy histogram", legend = false)
