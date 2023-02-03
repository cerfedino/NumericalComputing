#   M.L. for Numerical Computing class @USI - malik.lechekhab@usi.ch 
"""
    partition(coords, v)

Compute a `coords`-based partition using a line of direction `v`.

# Examples
```julia-repl
julia> partition(coords, [0 1])
([1, 2, 3, 9, 10], [4, 5, 6, 7, 8])
```
"""
function partition(coords, v)
    n, d = size(coords)
    
    v = v[:]
    dotprod = coords * v
    split = median(dotprod)
    a = findall(x -> x < split, dotprod)
    b = findall(x -> x > split, dotprod)
    c = findall(x -> x == split, dotprod)
    nc = length(c)
    
    if nc != 0
        na = length(a)
        nca = Int64(max(ceil(n/2)-na, 0))
        nca = Int64(min(nca, nc))

        if nca > 0
            a = [a; c[1:nca]]
        end
        if nca < nc
            b = [b; c[nca + 1: nc]]
        end
    end

    return a, b
end