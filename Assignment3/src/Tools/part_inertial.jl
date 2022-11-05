#   M.L. for Numerical Computing class @USI - malik.lechekhab@usi.ch 
"""
    inertial_part(A, coords)

Compute the bi-partions of graph `A` using inertial method based on the `coords` of the graph.

# Examples
```julia-repl
julia> inertial_part(A, coords)
 1
 ⋮
 2
```
"""
function inertial_part(A, coords)
    
    #   1.  Compute the center of mass.

    #   2.  Construct the matrix M. (see pdf of the assignment)

    #   3.  Compute the eigenvector associated with the smallest eigenvalue of M.


    #   4.  Partition the nodes around line L 
    #       (use may use the function partition(coords, eigv))

    #   5.  Return the indicator vector

    # RANDOM PARTITIONING - REMOVE AFTER COMPLETION OF THE EXERCISE
    n = size(A)[1];
    rng = MersenneTwister(1234);
    p = bitrand(rng, n);
    return p

end