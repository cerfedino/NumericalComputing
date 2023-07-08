using SparseArrays
using Plots
using LinearAlgebra

function A_construct(n)
    A = sparse(zeros(n,n));
    for i = 1:n
        for j = 1:n
            if (i == 1 || i == n || j ==1 || j == n ) && i != j
                A[i,j] = 1;
            elseif i == j
                A[i,j] = n + i -1;
            end
        end
    end

    nz = nnz(A);

    return A, nz
end

n = 10;
A, nz = A_construct(n);
show(stdout, "text/plain", A)
spy(A)

# d = cholesky(A)

# 2d)
plot(spy(A), spy(sparse(cholesky(A).L)), layout = (1,2))