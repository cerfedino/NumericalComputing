#   M.L. for Numerical Computing class @USI - malik.lechekhab@usi.ch
#   Main file of Project 3

#   I/O packages
using DelimitedFiles, MAT
#   Math packages
using Arpack, LinearAlgebra, Metis, Random, SparseArrays, Statistics
#   Plot packages
using Graphs, SGtSNEpi, GLMakie, Colors, CairoMakie, PrettyTables

using Suppressor
using FileIO, JLD2


#   Tools
#include("./Tools/add_paths.jl");
include("Tools/add_paths.jl")

#   Generate adjacency matrices and vertices coordinates
A, coords = getData("comman");

# only use x & y coordinates of the meshes
coords = coords[:,1:2]


#   Run benchmark

output = @capture_out benchmark_bisection()
open("out/benchmark_bisection.txt","a") do io
    println(output)
    println("\nSaving benchmark to file..")
    println(io,output)
 end

output = @capture_out benchmark_recursive()
open("out/benchmark_recursive.txt","a") do io
    println(output)
    println("\nSaving benchmark to file..")
    println(io,output)
 end

output = @capture_out benchmark_metis()
open("out/benchmark_metis.txt","a") do io
    println(output)
    println("\nSaving benchmark to file..")
    println(io,output)
 end