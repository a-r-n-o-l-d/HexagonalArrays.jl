using HexagonalArrays
using Test

@testset "HexagonalArrays" begin
    @testset "HexagonalIndex" begin
        include("hexagonal_index.jl")
    end

    @testset "HexagonalArray" begin
        include("hexagonal_array.jl")
    end

    @testset "HexagonalNeighborhood" begin
        include("hexagonal_neighborhood.jl")
    end

    include("extrapolation.jl")
end