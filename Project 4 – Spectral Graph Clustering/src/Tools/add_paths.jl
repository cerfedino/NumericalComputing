#   M.L. for Numerical Computing Lab @USI - malik.lechekhab@usi.ch 
# include all the necessary paths

include("../Datasets/two_spirals.jl");
include("../Datasets/corners.jl");
include("../Datasets/cluster_in_cluster.jl");
include("../Datasets/half_kernel.jl");
include("../Datasets/crescent.jl");
include("../Datasets/outlier.jl");

include("./create_laplacian.jl");
include("./epsilon_sim_graph.jl");
include("./get_points.jl");
include("./min_span_tree.jl");
include("./plot_partitions.jl");
include("./read_mat_graph.jl");
include("./similarity_func.jl");

