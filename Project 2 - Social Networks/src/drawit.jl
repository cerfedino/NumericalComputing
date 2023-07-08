function drawit(A, m, name, savefile_name)
    l1 = collect(1:(m-1))
    l2 = collect(m+1:size(A)[1])
    l3 = vcat(m, l1, l2)
    A = A[l3, l3]
    name = name[l3]

    G = Graph(A)
    nlist = Vector{Vector{Int}}() # two shells
    push!(nlist, collect([1])) # first shell
    push!(nlist, 2:nv(G)) # second shell
    locs_x, locs_y = shell_layout(G, nlist)
    draw(PNG(savefile_name, 16cm, 16cm), gplot(G, locs_x, locs_y, nodelabel=name, nodelabelsize=vcat(1, fill(0.5, nv(G)-1))))
    
end