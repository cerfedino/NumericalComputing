cd(dirname(@__FILE__))

# Packages
#   Data Importation
using MAT
#   Linear Algebra
using IterativeSolvers, LinearAlgebra, SparseArrays, Preconditioners
#   Plots
using Plots

# Load default image data
B = read(matopen("./Data/Blur/B.mat"), "B");
img = B;
n = size(img, 1);

# Show image
heatmap(reshape(img, (n, n)), c=:greys, yflip=true, legend=:none, axis=nothing, aspect_ratio=:equal)

# Vectorize img
img = vec(img);
