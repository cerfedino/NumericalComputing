#   M.L. for Numerical Computing class @USI - malik.lechekhab@usi.ch
"""
    benchmark_metis()

Run a benchmark of different meshes with METIS partitioning method.

# Examples
```julia-repl
julia> benchmark_metis()
```
"""
function benchmark_metis()
    meshes = ["commanche_dual" "skirt"]

    #   Init result array
    pAll = Array{Any}(undef, 4, length(meshes)+1)

    pAll[1,1] = "16-recursive bisection"
    pAll[2,1] = "16-way direct bisection"
    pAll[3,1] = "32-recursive bisection"
    pAll[4,1] = "32-way direct bisection"
    
    #   Loop through meshes
    for (i, mesh) in enumerate(meshes)
        println("\n\n",mesh,"\n===\n")
        #   Define path to mat file
        path = joinpath(dirname(@__DIR__),"Meshes","2D",mesh*".mat");

        #   Read data
        A, coords = read_mat_graph(path);

        p = metis_part(A, 16, :RECURSIVE)
        pAll[1,i+1] = cut = count_edge_cut(A, p)
        GLMakie.save("out/plots/metis/metis-$mesh-recursive-p16-cut:$cut.png",draw_graph(A, coords, p))

        p = metis_part(A, 16, :KWAY)
        pAll[2,i+1] = cut = count_edge_cut(A, p)
        GLMakie.save("out/plots/metis/metis-$mesh-kway-p16-cut:$cut.png",draw_graph(A, coords, p))

        p = metis_part(A, 32, :RECURSIVE)
        pAll[3,i+1] = cut = count_edge_cut(A, p)
        GLMakie.save("out/plots/metis/metis-$mesh-recursive-p16-cut:$cut.png",draw_graph(A, coords, p))

        p = metis_part(A, 32, :KWAY)
        pAll[4,i+1] = cut = count_edge_cut(A, p)
        GLMakie.save("out/plots/metis/metis-$mesh-kway-p16-cut:$cut.png",draw_graph(A, coords, p))

    end

    #   Print result table
    header =["Partitions","Helicopter","Skirt"]
    pretty_table(pAll; header = header, crop = :none, header_crayon = crayon"bold cyan")
end