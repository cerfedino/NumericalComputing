#   M.L. for Numerical Computing class @USI - malik.lechekhab@usi.ch
using DelimitedFiles, MAT, Arpack, LinearAlgebra
using Random, SparseArrays, Statistics
using Metis, Graphs, SGtSNEpi, GLMakie
using Colors, CairoMakie, PrettyTables

include("./bench_bisection.jl");
include("./bench_recursive.jl");
include("./bench_metis.jl");
include("./count_cut.jl");
include("./data_selector.jl");
include("./part_coordinate.jl");
include("./part_inertial.jl");
include("./part_metis.jl");
include("./part_spectral.jl");
include("./partition.jl");
include("./plot_partitions.jl");
include("./recursive_bisection.jl");
include("./read_mat_graph.jl")