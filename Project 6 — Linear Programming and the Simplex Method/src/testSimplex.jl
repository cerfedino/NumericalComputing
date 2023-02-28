# This script has the purpose of testing your implementation of the Simplex Method. In case there should be any issue with your solution; you will
# get an error & the code will stop. If your proposed solution passes all the tests; you can happily move to the next part of the assignment.

cd(dirname(@__FILE__))

include("simplex.jl")
include("simplexSolve.jl")
include("standardize.jl")
include("auxiliary.jl")
include("printSol.jl")

function strcmp(str1, str2)
    return cmp(str1, str2) == 0
end

## Test 1 (example page 86)
type = "max"
A = [[2, 1] [1, 3] [1, 1]]'
h = [360 480 220]'
c = [14 18]
sign = [0 0 0]

z, x_B, index_B = simplex(type, A, h, c, sign)

if (z == 3600 && sum(round.(Matrix(x_B') - [90 130 50])) == 0 && sum(index_B .== [1, 2, 3]) == 3)
    print("Test 1 has given the expected results. Proceding with the next one.\n\n")
else
    error("Test 1 has given a wrong result. Interrupting the testing phase.")
end
#pause()

## Test 2 (example page 114)
type = "min"
A = [[2, 1, 3] [3, 4, 2]]'
h = [210 360]'
c = [9 11 8]
sign = [0 0]

z, x_B, index_B = simplex(type, A, h, c, sign)

if (z == 1062 && sum(round.(Matrix(x_B') - [96 18])) == 0 && sum(index_B .== [1, 2]) == 2)
    print("Test 2 has given the expected results. Proceding with the next one.\n\n")
else
    error("Test 2 has given a wrong result. Interrupting the testing phase.")
end
#pause()

## Test 3 (example page 126)
type = "max"
A = [[1, 2, 1] [2, 1, 0] [1, -2, -1]]'
h = [5 8 1]'
c = [3 -2 5]
sign = [0 1 1]

z, x_B, index_B = simplex(type, A, h, c, sign)

if (z == 17 && sum(round.(Matrix(x_B') - [4 1 2])) == 0 && sum(index_B .== [1, 3, 6]) == 3)
    print("Test 3 has given the expected results. Proceding with the next one.\n\n")
else
    error("Test 3 has given a wrong result. Interrupting the testing phase.")
end
#pause()

## Test 4 (TED)
type = "min"
A = [[-10,-5,-8] [ -10,-2,-10] [ -5,-5,-4] [ 10,5,8] [ 10,2,10] [ 5,5,4]]'
h = [-110 -60 -90 78 43 70]'
c = [20000 30000 25000]
sign = [0 0 0 0 0 0]

z, x_B, index_B = simplex(type, A, h, c, sign)

# TODO: Look into the approximately equal to issue
if (z ≈ 380000 && sum(round.(Matrix(x_B') - [4 10 20 20 12 17])) == 0 && sum(index_B .== [1, 2, 4, 6, 7, 8]) == 6)
    print("Test 4 has given the expected results. Proceding with the next one.\n\n")
else
    error("Test 4 has given a wrong result. Interrupting the testing phase.")
end
#pause()

## Test 5 (LP Exercise 2)
type = "max"
A = [[1, 1, 2] [5, 3, 1] [2, 1, 0]]'
h = [1200 2000 600]'
c = [5 20 28]
sign = [0 0 0]

z, x_B, index_B = simplex(type, A, h, c, sign)

if (z == 20160 && sum(round.(Matrix(x_B') - [560 320 40])) == 0 && sum(index_B .== [2, 3, 6]) == 3)
    print("Test 5 has given the expected results. Proceding with the next one.\n\n")
else
    error("Test 5 has given a wrong result. Interrupting the testing phase.")
end
#pause()

## Test 6 (Vinitaly page 171)
type = "max"
A = [[1,1,1,0,0,0,0,0,0] [0,0,0,1,1,1,0,0,0] [0,0,0,0,0,0,1,1,1] [0,1,0,0,1,0,0,1,0] [0,0,1,0,0,1,0,0,1]]'
h = [4800 4000 2300 2500 4200]'
c = [2 3 4 4 7 12 4 9 13]
sign = [0 0 0 0 0]

z, x_B, index_B = simplex(type, A, h, c, sign)

if (z == 79500 && sum(round.(Matrix(x_B') - [4400 400 4000 2100 200])) == 0 && sum(index_B .== [1, 2, 6, 8, 9]) == 5)
    print("Test 6 has given the expected results. Congratulations!!!\n\n")
else
    error("Test 6 has given a wrong result. Interrupting the testing phase.")
end
