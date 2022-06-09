module HexagonalArrays

export d_unit_area, hexcount, hexvertices
include("utils.jl")

export HexagonalIndex, indices, to_cartesian, euclidean
include("hexagonal_index.jl")

export HexagonalArray, hexzeros, hexones
include("hexagonal_array.jl")

export @neighborhood
include("neighborhood.jl")

export Replicate, Constant, Periodic
include("extrapolation.jl")

end
