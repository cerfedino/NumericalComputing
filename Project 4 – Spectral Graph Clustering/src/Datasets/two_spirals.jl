#   M.L. for Numerical Computing Lab @USI - malik.lechekhab@usi.ch 
"""
        twospirals(N, degree, start, noise)

Create two embeded spirals of N points.
"""
function twospirals(N=2000, degree=570, start=90, noise=0.2)
    N1 = floor(Int, N/2);
    N2 = N - N1;

    start = start * π/180;
    degree = degree * π/180;

    n = start * sqrt.(rand(N1, 1)) * degree;
    d1 = [(-cos.(n) .* n + rand(N1,1) * noise) (sin.(n) .* n + rand(N1,1) * noise) zeros(N1,1)];

    n = start * sqrt.(rand(N1, 1)) * degree;
    d2 = [(cos.(n) .* n + rand(N2,1) * noise) (-sin.(n) .* n + rand(N2,1) * noise) ones(N2,1)];

    data = vcat(d1./2, d2./2);

    return data
end