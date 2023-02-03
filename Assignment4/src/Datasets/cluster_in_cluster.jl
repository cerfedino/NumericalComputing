#   M.L. for Numerical Computing Lab @USI - malik.lechekhab@usi.ch 
"""
    clusterincluster(N, r1, r2, w1, w2, arms)

Create two clusters of N points of radius r1 and r2.
"""
function clusterincluster(N = 1000, r1 = 1, r2 = 5 * r1, w1 = 0.8, w2 = 1/3, arms = 64)
    
    data = [];

    N1 = Int64(floor(N/2));
    N2 = N - N1
    ϕ1 = rand(N1) .* (2 * π)
    dist1 = r1 .+ (rand(1:3, N1, 1)) ./ 3 .* r1 .* w1;

    d1 = hcat(dist1 .* cos.(ϕ1), dist1 .* sin.(ϕ1), zeros(N1));

    perarm = round(N2/arms);
    N2 = Int64(perarm * arms);
    radperarm = (2 * π) / arms;
    ϕ2 = (collect(1:N2) - mod.(collect(1:N2), perarm)) ./ perarm .* radperarm;

    dist2 = r2 * (1 - w2 / 2) .+ r2 * w2 .* mod.(collect(1:N2), perarm) ./ perarm;
    d2 = hcat(dist2 .* cos.(ϕ2), dist2 .* sin.(ϕ2), ones(N2));

    data = [d1; d2];

    return data
end