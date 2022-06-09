@testset "Extrapolation" begin
    a = hexzeros(8, 4, 1)
    a[1, 1, 1] = 42
    e = Replicate(a)
    @test e[-1, -1, 1] == 42
    a[one(HexagonalIndex)] = 666
    @test e[one(HexagonalIndex) - one(HexagonalIndex)] == 666
end