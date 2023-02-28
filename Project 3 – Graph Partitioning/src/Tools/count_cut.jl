#   M.L. for Numerical Computing class @USI - malik.lechekhab@usi.ch 
"""
count_edge_cut(A, p)

Count the number of edge-cuts of graph `A` for a give partition `p`.

# Examples
```julia-repl
julia> count_edge_cut(A, p)
1.0
```
"""
function count_edge_cut(A, p)
    g = Graph(A)
    count = 0
    for v in vertices(g)
        for u in neighbors(g, v)
            if p[u] != p[v]
                count = count + 1
            end
        end
    end
    count = count / 2

    return count
end