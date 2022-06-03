@testset "HexagonalArray" begin
    H = HexagonalArray(rand(2, 2, 2), d_unit_area)
    H[1, 1, 1] = 1
    H[HexagonalIndex(2, 1, 1)] = 2
    H[3] = 3
    @test H[1] == 1.0
    @test H[2] == 2.0
    @test H[HexagonalIndex(1, 2, 1)] == 3.0

    
end