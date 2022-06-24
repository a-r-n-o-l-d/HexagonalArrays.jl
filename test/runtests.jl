using HexagonalArrays
using Test

# Add support of Aqua.jl

@testset "HexagonalArrays" begin
    @testset "HexagonalIndex" begin
        include("hexagonal_index.jl")
    end

    @testset "HexagonalArray" begin
        include("hexagonal_array.jl")
    end

    @testset "Extrapolation" begin
        #include("extrapolation.jl")
    end
end