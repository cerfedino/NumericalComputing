made: cluster_point.jl cluster_graphs.jl

clean:
	rm -r out

cluster_point.jl: out/1
	julia --project cluster_points.jl
cluster_graphs.jl: out/2
	julia --project cluster_graphs.jl

out/:
	mkdir -p out
out/1: out/
	mkdir -p out/1
out/2: out/
	mkdir -p out/2