#   M.L. for Numerical Computing Lab @USI - malik.lechekhab@usi.ch 
"""
        crescent(N, r1, r2, r3)

Create a full moon and a crescent of radius r1, r2 and r3.
"""
function crescent(N = 1000, r1 = 5, r2 = 10, r3 = 15)
    N1 = N ÷ 4;
    N2 = N - N1;

    ϕ1 = rand(N1) .* 2 * π;
    R1 = sqrt.(rand(N1));
    moon = hcat(
        cos.(ϕ1) .* R1 .* r1,
        sin.(ϕ1) .* R1 .* r1,
        zeros(N1)
    );

    d = r3 - r2;
    ϕ2 = π .+ rand(N2) .* π;
    R2 = sqrt.(rand(N2));
    crescent = hcat(
        cos.(ϕ2) .* (r2 .+ R2 .* d),
        sin.(ϕ2) .* (r2 .+ R2 .* d),
        ones(N2)
    );

    data = [moon ./ 2; crescent ./ 2];

    return data
end