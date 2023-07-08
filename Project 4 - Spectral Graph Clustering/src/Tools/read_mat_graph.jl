#   M.L. for High Performance Computing Lab @USI & @ETHZ - malik.lechekhab@usi.ch 
#   Data extraction method
"""
    read_mat_graph(path_file)

Extract the data located in the MAT `path_file`.
"""
function read_mat_graph(path_file)
    file = matopen(path_file)
    data = read(file)
    A = data["Problem"]["A"]
    coords = data["Problem"]["aux"]["coord"]

    if !issymmetric(A)
        A = (A + transpose(A))
    end

    return A, coords
end