module HexagonalArrays

export d_unit_area, hcount, hvertices
include("utils.jl")

export HexagonalIndex, to_cartesian, heuclidean, HexagonalIndices
include("hexagonal_index.jl")

export HexagonalArray, harray, hzeros, hones
include("hexagonal_array.jl")

export NeighborhoodIndex, HexagonalNeighborhood, @neighborhood
include("hexagonal_neighborhood.jl")

export Replicate, Constant, Periodic, Symmetric
include("extrapolation.jl")

end
