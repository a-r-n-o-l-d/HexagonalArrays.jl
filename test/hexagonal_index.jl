@testset "HexagonalIndex" begin
    @test (1, 1, 1) == indices(one(HexagonalIndex))

    @test one(HexagonalIndex) + one(HexagonalIndex) == 2 * one(HexagonalIndex)

    @test one(HexagonalIndex) - one(HexagonalIndex) == zero(HexagonalIndex)
    
    @test(0.0, 0.0) == to_cartesian(one(HexagonalIndex), 1)
end