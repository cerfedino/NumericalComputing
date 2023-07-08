function simplex(type, A, h, c, sign)
    # Simplex method solver for a linear programming problem
    # Input arguments:
    #   type = "max' for maximization; 'min" for minimization
    #   A    = matrix holding the constraints coefficients
    #   h    = coefficients of the constraints inequalities [rhs vector]
    #   c    = coefficients of the objective function
    #   sign = vector holding information about the constraints if the system()
    #          needs to be standardized [-1: less or equal, 0: equal, 1:vgreater | equal]

    m = size(A, 1)
    n = size(A, 2)

    # TODO: Compute the maximum number of basic solutions of the original problem [i.e., the maximum number of iterations necessary to solve the problem]
    itMax = factorial(big(m+n)) / (factorial(big(m))*factorial(big(n)))

    # Writing the problem in standard form
    A_aug, h, c_aug = standardize(type, A, h, c, m, sign)

    # Determining a starting feasible initial basic solution
    B, D, c_B, c_D, x_B, x_D, index_B, index_D = auxiliary(A_aug, c_aug, h, m, n)

    # Solving the linear programming problem with the Simplex method
    x_B, c_B, index_B = simplexSolve(type, B, D, c_B, c_D, h, x_B, x_D, index_B, index_D, itMax)

    # TODO: Compute the value of the objective function
    z = (c_B*x_B)[1]

    # Output of the solution
    x_B, index_B = printSol(z, x_B, index_B, m, n)
    
    @show z x_B index_B c_B
    return z, x_B, index_B
end
