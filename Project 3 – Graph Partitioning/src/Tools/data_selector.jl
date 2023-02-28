#   M.L. for Numerical Computing class @USI - malik.lechekhab@usi.ch 
#   Data extraction method
"""
    listFiles()

List the files available in the meshes folder.

# Examples
```julia-repl
julia> listFiles()
Dict{Any, Any} with 28 entries:
  "VN-4031-pts.csv" => "./Meshes/Countries/csv/VN-4031-pts.csv"
  ⋮                 => ⋮
```
"""
function listFiles()
    root = string(dirname(@__DIR__))
    root = joinpath(root, "Meshes")
    itr = collect(walkdir(root))
    filePaths = Dict()

    for i in itr
        path = i[1]
        files = i[3]
        if !isempty(files)
            for file in files
                filePaths[file] = joinpath(path, file)
            end
        end
    end

    return filePaths
end


"""
    getPath(files, request)

Get path of a `request`ed file among a list of `files`.
"""
function getPath(files, request)
    for k in keys(files)
        if occursin(request, k)
            ext = last(split(files[k], '.'))
            return files[k], ext
        end
    end

    @warn "file not found in the folder of Meshes"
end


"""
    getCSVFilesPath(path)

Get the CSV files paths available in a folder.
"""
function getCSVFilesPath(path)
    fullPath = split(path, '/')
    fileName = last(fullPath)
    splitName = split(fileName, '-')
    prefixName = splitName[1]*'-'*splitName[2]
    adjFileName = prefixName*"-adj.csv"
    coordFileName = prefixName*"-pts.csv"
    adjFilePath = "/"*string(joinpath(joinpath(fullPath[1:end-1]), adjFileName))
    coordFilePath = "/"*joinpath(joinpath(fullPath[1:end-1]), coordFileName)

    return adjFilePath, coordFilePath
end


"""
    buildAdjMat(edges, n)

Compute adjacency matrix based on the `edges` of a `n` by `n` graph.
"""
function buildAdjMat(edges, n)
    m = size(edges)[1]
    A = spzeros(n, n)
    for i in 1:m
        dst = edges[i, 1]
        src = edges[i, 2]

        A[dst, src] = 1
        A[src, dst] = 1 
    end
    
    return A
end


"""
    getData(request)

Extract the data from a `requested` MAT or CSV file.
"""
function getData(request)
    files = listFiles()
    path, ext = getPath(files, request)

    if ext == "mat"
        file = matopen(path)
        data = read(file)
        if haskey(data, "Problem")
            A = data["Problem"]["A"]
            coords = data["Problem"]["aux"]["coord"]
        else
            A = sparse(data["CH_adj"])
            coords = data["CH_coords"]
        end
    elseif ext == "csv"

        adjFilePath, coordFilePath = getCSVFilesPath(path)

        coords = readdlm(coordFilePath, ',', skipstart=1, '\n')

        edges = readdlm(adjFilePath, ',', Int32, skipstart=1, '\n')
        n = size(coords)[1]
        
        A = buildAdjMat(edges, n)  
    end

    if !issymmetric(A)
        A = (A + transpose(A))
    end

    return A, coords
end


"""
    testAdj(type)

Create small adjacency matrix of testing.

It is possible to choose between network `type` or triangles `type`.

# Examples
```julia-repl
julia> A = testAdj("network");
julia> A = testAdj("triangles");
```
"""
function testAdj(type)
    if type=="network"
        A = [[0. 1. 1. 0. 0. 1. 0. 0. 1. 1.]
            [1. 0. 1. 0. 0. 0. 0. 0. 0. 0.]
            [1. 1. 0. 0. 0. 0. 0. 0. 0. 0.]
            [0. 0. 0. 0. 1. 1. 0. 0. 0. 0.]
            [0. 0. 0. 1. 0. 1. 0. 0. 0. 0.]
            [1. 0. 0. 1. 1. 0. 1. 1. 0. 0.]
            [0. 0. 0. 0. 0. 1. 0. 1. 0. 0.]
            [0. 0. 0. 0. 0. 1. 1. 0. 0. 0.]
            [1. 0. 0. 0. 0. 0. 0. 0. 0. 1.]
            [1. 0. 0. 0. 0. 0. 0. 0. 1. 0.]]
        A = sparse(A)
        x = [3 1 2 4 5 3 2 1 5 4]
        y = [2 1 1 5 5 4 5 5 1 1]
    elseif type=="triangles"
        A = [   [0. 1. 1. 1. 0. 0. ]
                [1. 0. 1. 0. 1. 0. ]
                [1. 1. 0. 0. 0. 1. ]
                [1. 0. 0. 0. 1. 1. ]
                [0. 1. 0. 1. 0. 1. ]
                [0. 0. 1. 1. 1. 0. ]]
        A = sparse(A)
        x = [2 4 4 0 6 6]
        y = [3 2 4 3 0 6]
    end
    
    
    coords = hcat(vec(x), vec(y))

    return A, coords
    
end


"""
    grid(nrow, ncol, θ, full)

Generate and adj. matrix and coordinates of a rectangular grid of size `nrow` by `ncol`

It is possible to set a rotation angle `θ` and to add diagonal edges by setting `full` to true.

# Examples
```julia-repl
julia> grid(10, 20, 0, false)
```
"""
function grid(nrow, ncol, θ=0, full=false)
    
    N = nrow * ncol

    # A = spzeros(nrow, ncol)
    coords = reshape([],0,2)
    edges = reshape([],0,2)
    for i in 1:nrow
        for j in 1:ncol
            coords = vcat(coords, [j i])
            id = ncol*(i-1)+j
            if (i == 1 || i == nrow) && j < ncol
                edges = vcat(edges, [id id+1])
            end
            if (j == 1 || j == ncol) && i < nrow
                edges = vcat(edges, [id id+ncol])
            end
            if (j > 1 && j < ncol && i > 1 && i < nrow)
                edges = vcat(edges, [id id-ncol])
                edges = vcat(edges, [id id+ncol])
                edges = vcat(edges, [id id-1])
                edges = vcat(edges, [id id+1])
                if full
                    edges = vcat(edges, [id id-ncol-1])
                    edges = vcat(edges, [id id-ncol+1])
                    edges = vcat(edges, [id id+ncol-1])
                    edges = vcat(edges, [id id+ncol+1])
                end
            end
            if full
                if (i == nrow - 1 && j == 1) || (i == 1 && j == ncol - 1)
                    edges = vcat(edges, [id id+ncol+1])
                end
                if (i == 1 && j == 2) || (i == nrow - 1 && j == ncol)
                    edges = vcat(edges, [id id+ncol-1])
                end
            end
        end
    end

    if θ != 0
        R = [cos(θ) -sin(θ); sin(θ) cos(θ)]
        for i=1:size(coords)[1]
            coords[i,:]=R*coords[i,:]
        end
    end
    
    A = buildAdjMat(edges, N)
    return A, Float64.(coords)
end


"""
    gridt(n, θ)

Generate and adj. matrix and coordinates of a triangular grid of base size `n`.

It is possible to set a rotation angle `θ`.

# Examples
```julia-repl
julia> gridt(10, 0)
```
"""
function gridt(n, θ=0)
    coords = reshape([],0,2)
    edges = reshape([],0,2)
    skip = 0
    id_shift = 0
    for i in 1:n
        for j in 1:n
            if j > n - skip
                id_shift += skip
                break
            end
            coords = vcat(coords, [j+skip*0.5 i])
            id = n*(i-1)+j-id_shift
            if j < (n - skip)
                edges = vcat(edges, [id id+1])
            end
            if i < (n) && j < (n - skip)
                edges = vcat(edges, [id id+n-skip])
            end
            if j <= n - skip
                edges = vcat(edges, [id id+n-skip-1])
            end
        end
        skip = skip + 1
    end

    if θ != 0
        R = [cos(θ) -sin(θ); sin(θ) cos(θ)]
        for i=1:size(coords)[1]
            coords[i,:]=R*coords[i,:]
        end
    end
    N = size(coords)[1]
    A = buildAdjMat(edges, N)
    return A, Float64.(coords)
end