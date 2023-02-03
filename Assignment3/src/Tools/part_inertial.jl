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
    # Partitions two-dim matrix of x and y coordinates into array of tuples
    tuples = eachrow(coords)
    
    #   1.  Compute the center of mass.
    cm = reduce((acc,coord)->(acc[1]+coord[1], acc[2]+coord[2]),tuples, init=(0,0));
    cm = (cm[1]/length(tuples),cm[2]/length(tuples))
    # @show cm


    #   2.  Construct the matrix M. (see pdf of the assignment)
    sxx = reduce((sxx,coord)->sxx+(coord[1]-cm[1])^2,tuples,init=0)
    syy = reduce((syy,coord)->syy+(coord[2]-cm[2])^2,tuples,init=0) 
    sxy = reduce((sxy,coord)->sxy+(coord[1]-cm[1])*(coord[2]-cm[2]),tuples,init=0)
    M = [ sxx sxy ; sxy syy]
    # @show M


    #   3.  Compute the eigenvector associated with the smallest eigenvalue of M.
    λ, v = eigs(M,nev=1,which=:SR)
    v = v[:,1] # Smallest eigenvector
    # Find orthogonal vector
    w = [ v[2],-v[1] ];

    #   4.  Partition the nodes around line L 
    p = partition(coords,w)
    return map(x->x∈p[1] ? 1 : 2, collect(1:size(A)[1]))

end