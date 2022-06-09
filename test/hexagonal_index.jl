@testset "HexagonalIndex" begin
    @test (1, 1, 1) == indices(one(HexagonalIndex))

    @test one(HexagonalIndex) + one(HexagonalIndex) == 2 * one(HexagonalIndex)

    @test one(HexagonalIndex) - one(HexagonalIndex) == zero(HexagonalIndex)

    @test to_cartesian(one(HexagonalIndex), 1) == (0.0, 0.0)

    @test euclidean(HexagonalIndex(1,1,1), HexagonalIndex(2,1,1), 1) == 1.0


end