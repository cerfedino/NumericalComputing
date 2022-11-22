#   M.L. for Numerical Computing Lab @USI - malik.lechekhab@usi.ch 
using Distances
"""
        similarity(pts)

Create the similarity matrix 'S' from the coordinate list 'pts'.
"""
function similarity(pts)
    n = size(pts, 1);
    σ = 2*log(n);

    S = pairwise(Euclidean(), pts, dims = 1);
    S = exp.(-S .^ 2 ./ (2 * σ ^ 2));

    return S
end