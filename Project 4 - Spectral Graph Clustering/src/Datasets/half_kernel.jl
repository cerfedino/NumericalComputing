#   M.L. for Numerical Computing Lab @USI - malik.lechekhab@usi.ch 
"""
        halfkernel(N, minx, r1, r2, noise, ratio)

Create a half kernel of N points.
"""
function halfkernel(N = 1000, minx = -20, r1 = 20, r2 = 35, noise = 4, ratio = 0.6)
    ϕ1 = rand(N ÷ 2) .* π;
    inner = hcat(
        minx .+ r1 .* sin.(ϕ1) .- .5 .* noise .+ noise .* rand(N ÷ 2),
        r1 .* ratio .* cos.(ϕ1) .- .5 .* noise .+ noise .* rand(N ÷ 2),
        ones(N ÷ 2)
    );

    ϕ2 = rand(N ÷ 2) .* π;
    outer = hcat(
        minx .+ r2 .* sin.(ϕ2) .- .5 .* noise .+ noise .* rand(N ÷ 2),
        r2 .* ratio .* cos.(ϕ2) .- .5 .* noise .+ noise .* rand(N ÷ 2),
        zeros(N ÷ 2)
    );

    data = [inner ./ 4; outer ./ 4];

    return data
end