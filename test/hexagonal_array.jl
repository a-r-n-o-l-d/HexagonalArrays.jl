@testset "HexagonalArray" begin
    a = HexagonalArray(rand(2, 2, 2), d_unit_area)
    a[1, 1, 1] = 1
    a[HexagonalIndex(2, 1, 1)] = 2
    a[3] = 3
    @test a[1] == 1.0
    @test a[2] == 2.0
    @test a[HexagonalIndex(1, 2, 1)] == 3.0

    a = HexagonalArray(rand(2, 2, 2), d_unit_area)
    a1, a2, a3 = axes(a)
    tmp = map(z -> first(z) - HexagonalIndex(last(z)), zip(HexagonalIndices(a), Iterators.product(a1, a2, a3)))
    @test all(I -> I == zero(HexagonalIndex),tmp)
end