#   M.L. for Numerical Computing Lab @USI - malik.lechekhab@usi.ch 
"""
        createlaplacian(W)

Create the Laplacian matrix of matrix W. 
"""
function createlaplacian(W)

    n = size(W, 1);

    D = zeros(n, n);

    for i = 1:n 
        D[i, i] = sum(W[:, i]);
    end

    L = D - W;

    return L, D

end