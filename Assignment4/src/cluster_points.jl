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
    for ((index, pts),name) in zip(enumerate(getpoints()),mesh_names)
        # pts = getpoints()[1]
        # @show typeof(pts_dummy) pts_dummy
        n = size(pts, 1);

        #   Dummy variable
        # dummy_map = rand(1:K, size(pts, 1));

        #   Create Gaussian similarity function
        S = similarity(pts[:, 1:2]);


        # 1b) Find the mininal spanning tree of the full graph



        mintree = minspantree(S)
        # @show typeof(Matrix(mintree)) Matrix(mintree)
        GLMakie.save("out/1/0.MSP-'$name'.png",draw_graph(mintree, pts))
        GLMakie.save("out/1/0.'$name'.png",draw_graph(S,pts))

        #   Compute epsilon
        ϵ = maximum(mintree)

        # 1c) Compute the epsilon similarity graph
        G_e = epsilongraph(ϵ, pts)

        # 1d) Create the adjacency matrix for the epsilon case
        W_e = S .* G_e;
        GLMakie.save("out/1/4.'$name'-epsilon-adjacency.png",draw_graph(W_e, pts))

        # 1e) Create the Laplacian matrix and implement spectral clustering
        L, D = createlaplacian(W_e);

        #   Spectral method
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
        GLMakie.save("out/1/7.'$name'-K$K-kmeans.png",draw_graph(W_e, pts, data_assign))
        GLMakie.save("out/1/7.'$name'-K$K-spectral.png",draw_graph(W_e, pts, spec_assign))
        
        println("")
        @show name K ϵ
        println("")
    end
end