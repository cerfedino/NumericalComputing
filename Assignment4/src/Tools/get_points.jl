#   M.L. for Numerical Computing Lab @USI - malik.lechekhab@usi.ch 
using Plots
"""
        getpoints()

Plot and return list of points of various objects from Datasets folder.
"""
function getpoints()
    
    pts_spiral = twospirals();
    Plots.scatter(pts_spiral[:,1], pts_spiral[:,2], legend = false, aspect_ratio = 1)

    pts_clusterin = clusterincluster();
    Plots.scatter(pts_clusterin[:,1], pts_clusterin[:,2], group = pts_clusterin[:,3], legend = false, aspect_ratio = 1)

    pts_corn = corners();
    Plots.scatter(pts_corn[:,1], pts_corn[:,2], legend = false, aspect_ratio = 1)

    pts_halfk = halfkernel();
    Plots.scatter(pts_halfk[:,1], pts_halfk[:,2], group =  pts_halfk[:,3], legend = false, aspect_ratio = 1)

    pts_moon = crescent();
    Plots.scatter(pts_moon[:,1], pts_moon[:,2], group =  pts_moon[:,3], legend = false, aspect_ratio = 1)

    pts_outlier = outlier();
    Plots.scatter(pts_outlier[:,1], pts_outlier[:,2], group =  pts_outlier[:,3], legend = false, aspect_ratio = 1)

    marker = (:hexagon, 2, 0.6, :gray)

    display(Plots.plot(
        Plots.scatter(pts_spiral[:,1], pts_spiral[:,2],title = "Two spirals", marker = marker, legend = false, aspect_ratio = 1),
        Plots.scatter(pts_clusterin[:,1], pts_clusterin[:,2], title = "Cluster in cluster", marker = marker, legend = false, aspect_ratio = 1),
        Plots.scatter(pts_corn[:,1], pts_corn[:,2], title = "Corners", marker = marker, legend = false, aspect_ratio = 1),
        Plots.scatter(pts_halfk[:,1], pts_halfk[:,2], title = "Half-kernel", marker = marker, legend = false, aspect_ratio = 1),
        Plots.scatter(pts_moon[:,1], pts_moon[:,2], title = "Crescent & full moon", marker = marker, legend = false, aspect_ratio = 1),
        Plots.scatter(pts_outlier[:,1], pts_outlier[:,2], title = "Outlier", marker = marker, legend = false, aspect_ratio = 1)
    , size=(800,600)))

    return pts_spiral, pts_clusterin, pts_corn, pts_halfk, pts_moon, pts_outlier

end