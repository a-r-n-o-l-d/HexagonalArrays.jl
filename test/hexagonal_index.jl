@testset "HexagonalIndex" begin
    @test (1, 2, 2) == indices(HexagonalIndex(1, 2, 2))

    @test HexagonalIndex(1, 1, 1) + HexagonalIndex(1, 1, 1)
end