#   M.L. for Numerical Computing Lab @USI - malik.lechekhab@usi.ch 
"""
        outlier(N, r, dist, outliers, noise)

Create 4 objects: 2 large clusters and 2 small clusters.
"""

function outlier(N = 600, r = 20, dist = 30, outliers = 0.04, noise = 5)

    N1 = round(Int, N * (.5 - outliers));
    N2 = N1;
    N3 = round(Int, N * outliers);
    N4 = N - N1 - N2 - N3;

    ϕ1 = rand(N1) .* π;
    r1 = sqrt.(rand(N1)) .* r;
    P1 = hcat(
        -dist .+ r1 .* sin.(ϕ1),
        r1 .* cos.(ϕ1),
        zeros(N1)
    )

    ϕ2 = rand(N2) .* π;
    r2 = sqrt.(rand(N2)) .* r;
    P2 = hcat(
        dist .- r2 .* sin.(ϕ2),
        r2 .* cos.(ϕ2),
        3 .* ones(N1)
    );
    
    P3 = hcat(
        rand(N3) .* noise,
        dist .+ rand(N3) .* noise,
        2 .* ones(N3)
    );

    P4 = hcat(
        rand(N4) .* noise,
        -dist .+ rand(N4) .* noise,
        ones(N4)
    );

    data = [P1 ./ 4.5; P2 ./ 4.5; P3 ./ 4.5; P4 ./ 4.5];

    return data
end