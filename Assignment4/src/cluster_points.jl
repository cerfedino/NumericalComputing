# Cluster 2D real-world graphs with spectral clustering and compare with k-means 
# USI, ICS, Lugano
# Numerical Computing

using SparseArrays, LinearAlgebra, Arpack
using Clustering

include("./Tools/add_paths.jl");

# Specify the number of clusters
K = 2;

# 1a) Get coordinate list from point clouds
# ----------------------------
#     Your implementation
# ----------------------------

#   Coords used in this demo
#   TODO: Get the coordinate list from the function getpoints() located in the file /Tools/get_points.jl
pts_dummy = [rand(100,1)*5 rand(100,1)*5]
n = size(pts_dummy, 1);

#   Dummy variable
dummy_map = rand(1:K, size(pts_dummy, 1));
dummy_ϵ = 1;
#   Create Gaussian similarity function
S = similarity(pts_dummy[:, 1:2]);

# 1b) Find the mininal spanning tree of the full graph
# ----------------------------
#     Your implementation
#     (Hint: use the function minspantree() located in the file Tools/min_span_tree.jl)
# ----------------------------

#   Compute epsilon
# ----------------------------
#     Your implementation
# ----------------------------

# 1c) Compute the epsilon similarity graph
G_e = epsilongraph(dummy_ϵ, pts_dummy);
# ----------------------------
#     Your implementation
# ----------------------------

# 1d) Create the adjacency matrix for the epsilon case
# ----------------------------
#     Your implementation
# ----------------------------
W_e = S .* G_e;
draw_graph(W_e, pts_dummy)

# 1e) Create the Laplacian matrix and implement spectral clustering
L, D = createlaplacian(W_e);
# ----------------------------
#     Your implementation
# ----------------------------

#   Spectral method
# ----------------------------
#     Your implementation
#     (Hint: use eigsvals() and eigvecs())
# ----------------------------

# 1f) Run K-means on input data
R = kmeans(pts_dummy', K);
data_assign = R.assignments;

#   Cluster rows of eigenvector matrix of L corresponding to K smallest eigenvalues. Use kmeans as above.
R = kmeans(pts_dummy', K);
spec_assign = R.assignments;

# 1h) Visualize spectral and k-means clustering results
draw_graph(W_e, pts_dummy, data_assign)
draw_graph(W_e, pts_dummy, spec_assign)