#   M.L. for Numerical Computing class @USI - malik.lechekhab@usi.ch 
"""
    draw_graph(A, coords, p)

Plot the partitions `p` of graph `A`.
"""
function draw_graph(A, coords, p)
    GLMakie.activate!()
    set_theme!(theme_light())


    # colors = distinguishable_colors(10, [RGB(0,1,1), RGB(1,1,0)], dropseed=false)

    show_embedding(coords, p;
    A = A,        # show edges on embedding
    mrk_size = 0,                   # control node sizes
    lwd_in = 1, lwd_out = 0.3, # control edge widths
    edge_alpha = 1,
    res=(2000,2000),
    clr_out=colorant"gray",
    )
end


"""
    draw_graph(A, coords)

Plot the graph based on its adjacency matrix `A`.
"""
function draw_graph(A, coords)
    GLMakie.activate!()
    set_theme!(theme_light())

    n = size(A)[1]

    p = ones(Int, n)

    show_embedding(coords, p;
    A = A,        # show edges on embedding
    mrk_size = 0,                   # control node sizes
    lwd_in = 1, lwd_out = 0.3, # control edge widths
    edge_alpha = 1,
    res=(2000,2000),
    clr_out=colorant"gray",
    )
end
