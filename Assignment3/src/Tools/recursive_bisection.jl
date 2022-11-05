#   M.L. for Numerical Computing class @USI - malik.lechekhab@usi.ch 
"""
    rec_bisection(method, levels, A, coords=zeros(0), vn=zeros(0))

Compute recursive partitioning of graph `A` using a specified `method` and number of `levels`.

If the `method` is `coords`-based, coordinates must be passed.

# Examples
```julia-repl
julia> rec_bisection("spectralPart", 3, A)
 5
 ⋮
 2

julia> rec_bisection("coordinatePart", 3, A, coords)
 1
 ⋮
 8
```
"""
function rec_bisection(method, levels, A, coords=zeros(0), vn=zeros(0))
    minpoints = 8

    n = size(A)[1]

    if isempty(vn)
        vn = collect(1:n)
    end

    if n < minpoints || levels < 1
       
    else
        if !isempty(coords)
            p = eval(Symbol(method))(A, coords)
            idx1 = findall(x -> x == 1, p)
            idx2 = findall(x -> x == 2, p)
            coords1 = coords[idx1,:]
            coords2 = coords[idx2,:]
        else
            p = eval(Symbol(method))(A)
            idx1 = findall(x -> x == 1, p)
            idx2 = findall(x -> x == 2, p)
            coords1 = coords2 = zeros(0)
        end
        
        vn1 = vn[idx1]
        vn2 = vn[idx2]

        A1 = A[idx1, idx1]
        A2 = A[idx2, idx2]

        # if !isemtpy(coords)
        if levels > 1
            levels = levels - 1
            p1 = rec_bisection(method, levels, A1, coords1, vn1)
            p2 = rec_bisection(method, levels, A2, coords2, vn2)

            return vcat(p1, p2.+maximum(p1))[sortperm(vcat(vn1, vn2))]
            
        end

        return p[sortperm(vn)]
        # end

    end
end