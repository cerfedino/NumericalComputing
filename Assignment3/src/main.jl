#   M.L. for Numerical Computing class @USI - malik.lechekhab@usi.ch
#   Main file of Project 3

#   I/O packages
using DelimitedFiles, MAT
#   Math packages
using Arpack, LinearAlgebra, Metis, Random, SparseArrays, Statistics
#   Plot packages
using Graphs, SGtSNEpi, GLMakie, Colors, CairoMakie, PrettyTables

#   Tools
#include("./Tools/add_paths.jl");
include("Tools/add_paths.jl")

#   Generate adjacency matrices and vertices coordinates
A, coords = getData("comman");

# only use x & y coordinates of the meshes
coords = coords[:,1:2]


#   Run benchmark
benchmark_bisection()
benchmark_recursive()
benchmark_metis()


