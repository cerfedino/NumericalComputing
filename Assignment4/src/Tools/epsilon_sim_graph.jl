# USI, ICS, Lugano
# Numerical Computing
"""
        epsilongraph(ϵ, pts)

Construct an epsilon similarity graph based on the size of the neighborhood ϵ (calculated from Prim's algorithm) and the coordinates list pts.
"""
function epsilongraph(ϵ, pts)
    n = size(pts, 1);
    G = zeros(n, n);
    # ----------------------------
    #     Your implementation
    # ----------------------------
    for i = 1:n
        for j = 1:n
            if norm(pts[i,:]-pts[j,:]) < ϵ
                G[i,j] = 1
            end
        end
    end

    return sparse(G)

end