#   M.L. for Numerical Computing Lab @USI - malik.lechekhab@usi.ch 
using SimpleWeightedGraphs
"""
        minspantree(S)

Compute the minimum spanning tree of weighted adjacency matrix S.
"""
function minspantree(S)
    n = size(S, 1);

    src = zeros(Int, 0);
    dest = zeros(Int, 0);
    w = zeros(0);

    for i = 1:n
        for j = 1:n
            append!(src, i);
            append!(dest, j);
            append!(w, S[i, j])
        end
    end

    g = SimpleWeightedGraph(src, dest, w);

    min_sp = prim_mst(g);

    w_min_sp = zeros(n,n);
    for e in min_sp
        w_min_sp[e.src, e.dst] = S[e.src, e.dst];
        w_min_sp[e.dst, e.src] = S[e.dst, e.src];
    end

    return sparse(w_min_sp)
end


