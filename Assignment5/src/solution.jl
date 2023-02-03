cd(dirname(@__FILE__))
using Pkg; Pkg.activate(".");
# Packages
#   Data Importation
using MAT
#   Linear Algebra
using IterativeSolvers, LinearAlgebra, SparseArrays, Preconditioners
#   Plots
using Plots

Matrix(1I, 3, 3)
eigvals(Matrix(1I, 4, 4))


#### Exercise 3
### 3.1
function myCG(A,b,x0,max_itr,abstol)
    rvec = [];
    x = x0;
    r = b-A*x;
    d = r;

    p_old = dot(r,r)
    
    for i in 1:max_itr
        s = A*d;
        α = p_old / dot(d,s);
        x = x + α*d;
        r = r - α*s;
        p_new = dot(r,r);
        β = p_new / p_old;
        d = r + β*d;
        p_old = p_new;
        
        push!(rvec,p_new);
        if sqrt(p_new) <= abstol
            println("Converged")
            break
        end
    end
    return x, rvec
end

### 3.2

# Load test data
b_test = read(matopen("./Data/Test/b_test.mat"), "b_test");
img = b_test

# Blurred image
heatmap(reshape(img, (10, 10)), c=:greys, yflip=true, legend=:none, axis=nothing, aspect_ratio=:equal, xlabel="Blurred")
png("out/3.2-'B-test'-blurred")

# Load transformation matrix A
A_test = read(matopen("./Data/Test/A_test.mat"), "A_test");

## Run myCG() on B_test
guess = ones(size(A_test,1));
maxiter = 200;
abstol = 1e-4;

x,residuals = myCG(A_test,b_test,guess,maxiter,abstol)
# Deblurred image
heatmap(reshape(x, (10, 10)), c=:greys, yflip=true, legend=:none, axis=nothing, aspect_ratio=:equal, xlabel="Deblurred")
png("out/3.2-'B-test'-deblurred")

## Plot convergence
plot(residuals,  ylims=(-Inf,1e5), xlabel="Iterations",ylabel="Residual value",yscale=:log10)
# println(residuals)
png("out/3.2-'B-test'-convergence")



### 3.3
λ =  eigvals(A_test)
bar(1:size(λ,1), λ,xlabel="Eigenvalues [log10 scale]",legend = false,yscale=:log10)
annotate!(0, 2500, text("min (|λ|): "*string(minimum(abs,λ)),:black,:left,11))
annotate!(0, 1000, text("max(|λ|): "*string(maximum(abs,λ)),:black,:left,11))
annotate!(0, 400, text("κ(A): "*string(maximum(abs,λ)/minimum(abs,λ)),:black,:left,11))
png("out/3.2-'B-test'-eigvals")


### Exercise 4
# Load default image data
B = read(matopen("./Data/Blur/B.mat"), "B");
img = B;
n = size(img, 1)
# Vectorize image
b = vec(B)

# Show image
heatmap(reshape(img, (n, n)), c=:greys, yflip=true, legend=:none, axis=([],false), aspect_ratio=:equal)
png("out/4.1-'B'-blurred")


# Load transformation matrix A
A = read(matopen("./Data/Blur/A.mat"), "A");

# The initial guess
guess = ones(size(b,1));
# The maximum amount of iterations
maxiter = 200;
# The absolute tolerance
abstol = 1e-4;

# Compute augmented matrix to ensure positive-definedness and symmetricity
augA = A'A
# Shift diagonal by 0.01 to ensure the existance of IC factors
augA = 0.01*I+augA
# Retrieve the Cholesky preconditioner matrix with memory fill set to 1
P = CholeskyPreconditioner(augA,1);

x, residuals  = IterativeSolvers.cg(A,b,log=true,Pl=P,maxiter=maxiter,abstol=abstol)
# Draw deblurred image obtained with 'IterativeSolvers.cg(...)'
heatmap(reshape(x, (n, n)), c=:greys, yflip=true, legend=:none, axis=([],false), aspect_ratio=:equal)
png("out/4.1-'B'-'cg()'-deblurred")
# Plot residual variation for 'IterativeSolvers.cg(...)'
plot(residuals,  ylims=(-Inf,1e5), xlabel="Iterations",ylabel="Residual value",yscale=:log10)
png("out/4.1-'B'-'cg()'-convergence")


x,residuals = myCG(A,b,guess,maxiter,abstol)
# Draw deblurred image obtained with 'IterativeSolvers.cg(...)'
heatmap(reshape(x, (n, n)), c=:greys, yflip=true, legend=:none, axis=([],false), aspect_ratio=:equal)
png("out/4.1-'B'-'myCG()'-deblurred")

# Plot residual variation for 'myCG()'
plot(residuals, ylims=(-Inf,1e5), xlabel="Iterations",ylabel="Residual value",yscale=:log10)
png("out/4.1-'B'-'myCG()'-convergence")
