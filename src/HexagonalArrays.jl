module HexagonalArrays

export d_unit_area, hcount, hvertices
include("utils.jl")

export HexagonalIndex, to_cartesian, heuclidean
include("hexagonal_index.jl")

export HexagonalArray, harray, hzeros, hones
include("hexagonal_array.jl")

export HexagonalIndices
include("hexagonal_indices.jl")

export Replicate, Constant, Periodic, Symmetric
include("extrapolation.jl")

end