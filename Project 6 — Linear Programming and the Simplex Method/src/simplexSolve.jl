# B = Basic matrix
# D = non-basic matrix

function simplexSolve(type, B, D, c_B, c_D, h, x_B, x_D, index_B, index_D, itMax)
    # Solving a maximization problem with the simplex method

    # Initialize the number of iterations
    nIter = 0

    # Compute B^{-1}*D & B^{-1}*h
    BiD = B \ D
    Bih = B \ h

    # TODO: Compute the reduced cost coefficients
    function reduced_cost_coeff(c_D, c_B, B, D)
        return c_D - (c_B * (B \ D))
    end

    r_D = reduced_cost_coeff(c_D, c_B, B, D)

    tol = length(r_D) # the optimality condition is satisfied if all reduced cost coefficients are positive/negative (depending on the problem)

    # TODO: Check the optimality condition, in order to skip the loop if the solution is already optimal
    if strcmp(type, "max")
        optCheck = sum((i)->i<=0,r_D)
    elseif strcmp(type, "min")
        optCheck = sum((i)->i>=0,r_D)
    else
        error("Incorrect type specified. Choose either a maximisation [max] | minimisation [min] problem.")
    end
    while (optCheck != tol)
        # TODO: Find the index of the entering variable
        if strcmp(type, "max")
            @show idxIN = findmax(r_D)[2][2]
        elseif strcmp(type, "min")
            @show idxIN = findmin(r_D)[2][2]
        else
            error("Incorrect type specified. Choose either a maximisation [max] | minimisation [min] problem.")
        end

        in = D[:, idxIN]
        c_in = c_D[1, idxIN]
        index_in = index_D[1, idxIN]

        # TODO: Evaluate the coefficients ratio for the column corresponding to the entering variable
        ratio = Bih ./ ((B^-1)*in)

        # TODO: Find the smallest positive ratio
        idxOUT = findmin((i)->i>=0 ? i : Inf,ratio)[2][1]

        out = B[:, idxOUT]
        c_out = c_B[1, idxOUT]
        index_out = index_B[1, idxOUT]

        # TODO: Update the matrices by exchanging the columns
        B[:, idxOUT] = D[:, idxIN]
        D[:, idxIN] = B[:, idxOUT]
        c_B[1, idxOUT] = c_D[1, idxIN]
        c_D[1, idxIN] = c_B[1, idxOUT]
        index_B[1, idxOUT] = index_D[1, idxIN]
        index_D[1, idxIN] = index_B[1, idxOUT]

        # Compute B^{-1}*D & B^{-1}*h
        BiD = B \ D
        Bih = B \ h

        # TODO: Compute the reduced cost coefficients
        r_D = reduced_cost_coeff(c_D,c_B, B,D)

        # TODO: Check the optimality condition
        if strcmp(type, "max")
            optCheck = sum((i)->i<=0,r_D)
        elseif strcmp(type, "min")
            optCheck = sum((i)->i>=0,r_D)
        else
            error("Incorrect type specified. Choose either a maximisation [max] | minimisation [min] problem.")
        end

        # Detect inefficient loop if nIter .> total number of basic solutions
        nIter = nIter + 1
        if(nIter > itMax)
           error("Incorrect loop, more iterations than the number of basic solutions")
        end
        
        # TODO: Compute the new x_B
        x_B = Bih - BiD*x_D

    end

    return x_B, c_B, index_B
end
