#   M.L. for Numerical Computing class @USI - malik.lechekhab@usi.ch 
"""
    spectral_part(A)

Compute the bi-partions of graph `A` using spectral method.

# Examples
```julia-repl
julia> spectral_part(A)
 1
 ⋮
 2
```
"""
function spectral_part(A)
    n = size(A)[1]

    if n > 4*10^4
        @warn "graph is large. Computing eigen values may take too long."     
    end
    
    #   1.  Construct the Laplacian matrix.
    D = Diagonal(vec(sum(A,dims=1)))
    L = Matrix(D-A);
    # print(L);
  

    #   2.  Compute its eigendecomposition.
    λ = eigen(L);
    w = λ.vectors[:,sortperm(λ.values)[2]];


    #   3.  Label the vertices with the entries of the Fiedler vector.

    #   4.  Partition them around their median value, or 0.


    m = median(w);
    #   5.  Return the indicator vector
    return map(x->x < m ? 1 : 2, w);
end