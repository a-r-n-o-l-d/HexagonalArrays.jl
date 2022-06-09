@testset "Extrapolation" begin
    a = hexzeros(8, 4, 1)
    a[1, 1, 1] = 42
    e = Replicate(a)
    @test e[-1, -1, 1] == 42
    a[one(HexagonalIndex)] = 666
    @test e[one(HexagonalIndex) - one(HexagonalIndex)] == 666

    a = hexones(8, 4, 1)
    e = Constant(a, 42)
    @test e[-1, -1, 1] == 42
    @test e[one(HexagonalIndex) - one(HexagonalIndex)] == 42

    a = hexones(8, 4, 1)
    a[8, 1, 1] = 42
    a[8, 4, 2] = 42
    e = Constant(a, 42)
    @test e[0, 1, 1] == 42
    @test e[one(HexagonalIndex) - one(HexagonalIndex)] == 42
end