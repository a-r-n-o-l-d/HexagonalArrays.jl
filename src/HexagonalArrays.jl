module HexagonalArrays

export d_unit_area, hexcount, hexvertices
include("utils.jl")

export HexagonalIndex, to_cartesian, euclidean, HexagonalIndices
include("hexagonal_index.jl")

export HexagonalArray, hexzeros, hexones
include("hexagonal_array.jl")

export @neighborhood
include("neighborhood.jl")

export Replicate, Constant, Periodic, Symmetric
include("extrapolation.jl")

end
