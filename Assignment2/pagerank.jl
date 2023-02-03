using MAT, SparseArrays, LinearAlgebra, Plots

"""
    page_rank()

Compute pagerank from matrix A, names U and damping factor p.

# Examples
```julia-repl
julia> page_rank("", A, pr)
```
"""
function page_rank(U, G, p)
    
    G = G - diagm(diag(G))

    n = size(G)[2]

    # c = out-degree, r = in-degree
    c = vec(sum(G, dims=1))
    r = vec(sum(G, dims=2))

    k = findall(!iszero, c)
    D = sparse(k, k, map(x -> 1/x, c[k]), n, n)

    e = ones(n, 1)
    sI = sparse(I, n, n)


    # Default implementation
    x = (sI - p * G * D) \ e

    #Normalize
    x = x/sum(x)

    return vec(x), c, r
end