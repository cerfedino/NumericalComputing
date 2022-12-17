function printSol(z, x_B, index_B, m, n)
    # This function prints the solution while distinguishing between original
    # variables & slack variables

    index = sortperm(index_B[:]) #sortperm(index_B)
    x_B = x_B[index]
    sorted = index_B[index]
    index_B = sorted # TODO: Why copy sorted to index_B? Why can't we just use one of these for both?

    print("Variables & optimal solution:\n\n")
    for i = 1:m
        if(index_B[i] < n+1)
            println("x", sorted[i], " = ", x_B[i])
        else()
            println("s", sorted[i] - n, " = ", x_B[i])
        end
    end
    print("\nOptimal value of z = ", z, "\n\n")

    return x_B, index_B
end
