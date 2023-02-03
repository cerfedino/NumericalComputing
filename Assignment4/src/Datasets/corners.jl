#   M.L. for Numerical Computing Lab @USI - malik.lechekhab@usi.ch 
"""
        corners(N, scale, gapwidth, cornerwidth)

Create four corners of N points.
"""
function corners(N = 1000, scale = 10, gapwidth = 2, cornerwidth = 2)

    perCorner = Int64(N/4);

    xplusmin = [ones(perCorner); -1 .* ones(perCorner); ones(perCorner); -1 .* ones(perCorner)];

    yplusmin = [ones(perCorner); -1 .* ones(2*perCorner); ones(perCorner)];

    horizontal = hcat(
            xplusmin[1:2:end] .* gapwidth + xplusmin[1:2:end] .* scale .* rand(Int64(N/2)),
            yplusmin[1:2:end] .* gapwidth + cornerwidth .* yplusmin[1:2:end] .* rand(Int64(N/2)),
            floor.(collect(0:N/2-1)./(perCorner/2))
    );
    
    vertical = hcat(
            xplusmin[2:2:end] .* gapwidth + cornerwidth .* xplusmin[2:2:end] .* rand(Int64(N/2)),
            yplusmin[2:2:end] .* gapwidth + yplusmin[2:2:end] .* scale .* rand(Int64(N/2)),
            floor.(collect(0:N/2-1)./(perCorner/2))
    );

    data = [horizontal ./ 2 ; vertical ./ 2];

    return data
end