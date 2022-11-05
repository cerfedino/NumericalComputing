#   M.L. for Numerical Computing class @USI - malik.lechekhab@usi.ch 
"""
    coordinate_part(A, coords)

Compute the bi-partions of graph `A` using coordinate method based on the `coords` of the graph.

# Examples
```julia-repl
julia> coordinate_part(A, coords)
 1
 ⋮
 2
```
"""
function coordinate_part(A, coords)
    d = size(coords)[2]
    best_cut = Inf
    p = ones(Int, size(coords)[1])
    p_temp = ones(Int, size(coords)[1])
    for dim in 1:d
        v = zeros(d)
        v[dim] = 1
        p1, p2 = partition(coords, v)
        p_temp[p1] .= 1
        p_temp[p2] .= 2
        this_cut = count_edge_cut(A, p_temp)
        if this_cut < best_cut
            best_cut = this_cut
            p = ones(Int, size(coords)[1])
            p[p1] .= 1
            p[p2] .= 2
        end
    end
    
    return p
end
