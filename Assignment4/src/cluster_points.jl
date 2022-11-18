# Cluster 2D real-world graphs with spectral clustering and compare with k-means 
# USI, ICS, Lugano
# Numerical Computing

using SparseArrays, LinearAlgebra, Arpack
using GLMakie
using Clustering

include("./Tools/add_paths.jl");
include("./Tools/get_points.jl");
include("./Tools/min_span_tree.jl");

# Specify the number of clusters
for K in [2,4]
#   Coords used in this demo
    mesh_names = ["pts_spiral", "pts_clusterin", "pts_corn", "pts_halfk", "pts_moon", "pts_outlier"]
    # 1a) Get coordinate list from point clouds
    # ----------------------------
    #     Your implementation
    # ----------------------------
    for (index, pts) in enumerate(getpoints())
        # pts = getpoints()[1]
        # @show typeof(pts_dummy) pts_dummy

        n = size(pts, 1);

        #   Dummy variable
        # dummy_map = rand(1:K, size(pts, 1));

        #   Create Gaussian similarity function
        S = similarity(pts[:, 1:2]);

        # 1b) Find the mininal spanning tree of the full graph
        # ----------------------------
        #     Your implementation
        #     (Hint: use the function minspantree() located in the file Tools/min_span_tree.jl)
        # ----------------------------
        mintree = minspantree(S)
        # @show typeof(Matrix(mintree)) Matrix(mintree)

        #   Compute epsilon
        # ----------------------------
        #     Your implementation
        # ----------------------------
        ϵ = maximum(mintree)
        # 1c) Compute the epsilon similarity graph
        # ----------------------------
        #     Your implementation
        # ----------------------------
        G_e = epsilongraph(ϵ, pts)

        # 1d) Create the adjacency matrix for the epsilon case
        # ----------------------------
        #     Your implementation
        # ----------------------------
        W_e = S .* G_e;
        # draw_graph(W_e, pts)

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
        lambda = eigvals(L);
        Y = eigvecs(L);
        ind = sortperm(lambda);
        Y = Y[:,ind[begin:K]]

        # 1f) Run K-means on input data
        R = kmeans(pts', K);
        data_assign = R.assignments;

        #   Cluster rows of eigenvector matrix of L corresponding to K smallest eigenvalues. Use kmeans as above.
        R = kmeans(Y', K);
        spec_assign = R.assignments;

        # 1h) Visualize spectral and k-means clustering results
        GLMakie.save("out/plots/1/$(mesh_names[index])-K$K-kmeans.png",draw_graph(W_e, pts, data_assign))
        GLMakie.save("out/plots/1/$(mesh_names[index])-K$K-spectral.png",draw_graph(W_e, pts, spec_assign))

        # draw_graph(W_e, pts, data_assign) # K-means
        # draw_graph(W_e, pts, spec_assign) # Spectral
    end
end