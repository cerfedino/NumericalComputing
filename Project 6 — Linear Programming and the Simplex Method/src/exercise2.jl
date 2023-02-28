cd(dirname(@__FILE__))

include("simplex.jl")
include("simplexSolve.jl")
include("standardize.jl")
include("auxiliary.jl")
include("printSol.jl")

function strcmp(str1, str2)
    return cmp(str1, str2) == 0
end

# Input arguments:
#   type = "max' for maximization; 'min" for minimization
#   A    = matrix holding the constraints coefficients
#   h    = coefficients of the constraints inequalities [rhs vector]
#   c    = coefficients of the objective function
#   sign = vector holding information about the constraints if the system()
#          needs to be standardized [-1: less or equal, 0: equal, 1:vgreater | equal]

type = "max"
A = [[1,0,0,0, 1,0,0,0 ,1,0,0,0 ,1,0,0,0 ] [0,1,0,0 ,0,1,0,0 ,0,1,0,0 ,0,1,0,0 ] [0,0,1,0 ,0,0,1,0 ,0,0,1,0 ,0,0,1,0 ] [0,0,0,1 ,0,0,0,1 ,0,0,0,1 ,0,0,0,1 ] [320,0,0,0 ,510,0,0,0 ,630,0,0,0 ,125,0,0,0 ] [0,320,0,0 ,0,510,0,0 ,0,630,0,0 ,0,125,0,0 ] [0,0,320,0 ,0,0,510,0 ,0,0,630,0 ,0,0,125,0 ] [0,0,0,320 ,0,0,0,510 ,0,0,0,630 ,0,0,0,125 ] [1,1,1,1 ,0,0,0,0 ,0,0,0,0 ,0,0,0,0 ] [0,0,0,0 ,1,1,1,1 ,0,0,0,0 ,0,0,0,0 ] [0,0,0,0 ,0,0,0,0 ,1,1,1,1 ,0,0,0,0 ] [0,0,0,0 ,0,0,0,0 ,0,0,0,0 ,1,1,1,1 ]]'

h = [ 18 32 25 17 11930 22552 11209 5870 16 32 40 28 ]'
sign = [ -1 -1 -1 -1  -1 -1 -1 -1  -1 -1 -1 -1 ]
c = [ 135 135*1.1 135*1.2 135*1.3    200 200*1.1 200*1.2 200*1.3    410 410*1.1 410*1.2 410*1.3    520 520*1.1 520*1.2 520*1.3]  
z, x_B, index_B = simplex(type, A, h, c, sign)

@show z, x_B, index_B