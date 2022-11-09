#   M.L. for Numerical Computing class @USI - malik.lechekhab@usi.ch
"""
    benchmark_recursive()

Run a benchmark of different meshes with different recursive partitioning method.

# Examples
```julia-repl
julia> function benchmark_recursive()
()
```
"""
function benchmark_recursive()
    #   List the meshes to compare
    meshes = ["airfoil1" "netz4504_dual" "stufe" "3elt" "barth4" "ukerbe1" "crack"]

    #   List the algorithms to recursively run and compare
    algs = ["Spectral" "Spectral" "Metis" "Metis" "Coordinate" "Coordinate" "Inertial" "Inertial"]

    #   Init result array
    pAll = Array{Any}(undef, length(meshes), length(algs) + 1)

    #   Loop through meshes
    for (i, mesh) in enumerate(meshes)
        println("\n\n",mesh,"\n===\n")
        #   Define path to mat file
        path = joinpath(dirname(@__DIR__),"Meshes","2D",mesh*".mat");

        #   Read data
        A, coords = read_mat_graph(path);
        #   1st row
        pAll[i, 1] = mesh

        #   Recursive routines
        #   1.  Spectral
        # println("RUNNING SPECTRAL")
        println("-> spectral_part")
        p = rec_bisection("spectral_part",3,A)
        pAll[i,2] = cut = count_edge_cut(A, p)
        GLMakie.save("out/plots/recursive-$mesh-spectral-p8-cut:$cut.png",draw_graph(A, coords, p))

        p = rec_bisection("spectral_part",4,A)
        pAll[i,3] = cut = count_edge_cut(A, p)
        GLMakie.save("out/plots/recursive-$mesh-spectral-p16-cut:$cut.png",draw_graph(A, coords, p))

        # pAll[i,3] = count_edge_cut(A, )

        #   2.  METIS
        # println("RUNNING METIS")
        println("-> metis_part")
        # pAll[i,4] = count_edge_cut(A, metis_part(A, 8, :RECURSIVE))
        p = metis_part(A, 8, :RECURSIVE)
        pAll[i,4] = cut = count_edge_cut(A, p)
        GLMakie.save("out/plots/recursive-$mesh-metis-p8-cut:$cut.png",draw_graph(A, coords, p))

        p = metis_part(A, 16, :RECURSIVE)
        pAll[i,5] = cut = count_edge_cut(A, p)
        GLMakie.save("out/plots/recursive-$mesh-metis-p16-cut:$cut.png",draw_graph(A, coords, p))


        #   3.  Coordinate
        # println("RUNNING COORDINATE")
        println("-> coordinate_part")
        p = rec_bisection("coordinate_part",3,A,coords)
        pAll[i,6] = cut = count_edge_cut(A, p)
        GLMakie.save("out/plots/recursive-$mesh-coordinate-p8-cut:$cut.png",draw_graph(A, coords, p))

        p = rec_bisection("coordinate_part",4,A,coords)
        pAll[i,7] = cut = count_edge_cut(A, p)
        GLMakie.save("out/plots/recursive-$mesh-coordinate-p16-cut:$cut.png",draw_graph(A, coords, p))

        # pAll[i,6] = count_edge_cut(A, rec_bisection("coordinate_part",3,A,coords))
        # pAll[i,7] = count_edge_cut(A, rec_bisection("coordinate_part",4,A,coords))


        #   4.  Inertial
        # println("RUNNING INERTIAL")
        println("-> inertial_part")
        p = rec_bisection("inertial_part",3,A,coords)
        pAll[i,8] = cut = count_edge_cut(A, p)
        # GLMakie.save("out/plots/recursive-$mesh-inertial-p8-cut:$cut.png",draw_graph(A, coords, p))

        p = rec_bisection("inertial_part",4,A,coords)
        pAll[i,9] = cut = count_edge_cut(A, p)
        GLMakie.save("out/plots/recursive-$mesh-inertial-p16-cut:$cut.png",draw_graph(A, coords, p))

        # pAll[i,9] = count_edge_cut(A, rec_bisection("inertial_part",4,A,coords))

    end

    #   Print result table
    header =(hcat(["Mesh"], algs), ["" "8 parts" "16 parts" "8 parts" "16 parts" "8 parts" "16 parts" "8 parts" "16 parts"])
    pretty_table(pAll; header = header, crop = :none, header_crayon = crayon"bold cyan")
end
