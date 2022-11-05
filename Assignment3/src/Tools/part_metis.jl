#   M.L. for Numerical Computing class @USI - malik.lechekhab@usi.ch 
"""
    metis_part(A, k, alg)

Compute the `k` partions of graph `A` using METIS.

The partitioning method `alg` can be :KWAY or :RECURSIVE.

# Examples
```julia-repl
julia> metis_part(A, 2, :RECURSIVE)
 1
 ⋮
 2
```
"""
function metis_part(A, k, alg)
    g = Graph(A)
    p = Metis.partition(g, k, alg = alg)
    p = Int.(p)

    return p
end