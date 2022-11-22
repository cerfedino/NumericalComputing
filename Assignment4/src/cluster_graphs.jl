# Cluster 2D real-world graphs with spectral clustering and compare with k-means 
# USI, ICS, Lugano
# Numerical Computing

using SparseArrays, LinearAlgebra, Arpack
using Clustering
using GLMakie, PrettyTables, Suppressor
using MAT

include("Tools/add_paths.jl");

# Number of clusters
K = 4;


meshes = [
            ("./Datasets/Meshes/airfoil1.mat","airfoil1"),
            ("./Datasets/Meshes/barth4.mat","barth4"),
            ("./Datasets/Meshes/3elt.mat","3elt"),
        ]
header = ["Case", "Spectral", "K-Means"]
pAll=Array{Any}(undef, 3, length(meshes))
for (idx,(path, name)) in enumerate(meshes)
    # (path, name) = mesh
    W, pts = read_mat_graph(path);

    # 2a) Create the Laplacian matrix and plot the graph
    # ----------------------------
    #     Your implementation
    # ----------------------------
    # TODO: I never use D.. Is it correct ?
    L, D = createlaplacian(W)

    #   Eigen-decomposition
    # ----------------------------
    #     Your implementation
    #     (Hint: use eigsvals() and eigvecs())
    # ----------------------------

    lambda = eigvals(L);
    Y = eigvecs(L);
    ind = sortperm(lambda);
    Y = Y[:,ind[begin:K]]

    # Plot and compare 
    GLMakie.save("out/2/1.'$name'-laplacian_plot.png",draw_graph(L, pts))
    GLMakie.save("out/2/1.'$name'-eigenvector_plot.png",draw_graph(W, Y[:,2:3]))

    # 2b) Cluster each graph in K = 4 clusters with spectral and k-means method, compare your results visually for each case.

    # ----------------------------
    #     Your implementation
    # ----------------------------
    # K-means on input data
    R = kmeans(pts', K);
    data_assign = R.assignments;

    # K-means on eigenvectors (Spectral)
    R = kmeans(Y', K);
    spec_assign = R.assignments;


    #   Plot and compare
    GLMakie.save("out/2/2.'$name'-K$K-kmeans.png",draw_graph(W, pts, data_assign))
    GLMakie.save("out/2/2.'$name'-K$K-spectral.png",draw_graph(W, pts, spec_assign))

    # 2c) Calculate the number of nodes per clustering
    GLMakie.save("out/2/3.'$name'-K$K-kmeans_histogram.png",histogram(data_assign, title = "K-means histogram", legend = false))
    GLMakie.save("out/2/3.'$name'-K$K-spectral_histogram.png",histogram(spec_assign, title = "Spectral histogram", legend = false))

    
    function countClusterAssign(assign)
        K = maximum(assign)+1
        return Int.(mapreduce(x->[j==x+1 for j in 1:K], +,assign, init=zeros(K)))
    end
    pAll[idx,1] = "$name"
    pAll[idx,2] = join(countClusterAssign(spec_assign),",")
    pAll[idx,3] = join(countClusterAssign(data_assign),",")

 end



output = @capture_out pretty_table(pAll; header = header, crop = :none, header_crayon = crayon"bold green")
println(output)
open("out/2/3.clustering_results-K$K.txt","w") do io
    println(io,output)
end
