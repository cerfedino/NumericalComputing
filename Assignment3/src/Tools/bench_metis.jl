#   M.L. for Numerical Computing class @USI - malik.lechekhab@usi.ch
"""
    benchmark_metis()

Run a benchmark of different meshes with METIS partitioning method.

# Examples
```julia-repl
julia> benchmark_metis()
```
"""
function benchmark_metis()
    #   1.  Load commanche_dual.mat and skirt.mat
    
    #   2.  Call metis_part to:
    #       a) Recursively partition the graphs in 16 and 32 subsets.
    #       b) Perform direct k-way partitioning of the graphs in 16 and 32 subsets.

    #   3.  Visualize the results for 16 and 32 partitions.
end