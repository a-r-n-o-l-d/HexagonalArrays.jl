@testset "HexagonalArray" begin
    A = HexagonalArray(rand(2, 2, 2), d_unit_area)
    A[1, 1, 1] = 1
    A[HexagonalIndex(2, 1, 1)] = 2
    A[3] = 3
    @test A[1] == 1.0
    @test A[2] == 2.0
    @test A[HexagonalIndex(1, 2, 1)] == 3.0

    a = HexagonalArray(rand(2, 2, 2), d_unit_area)
    a1, a2, a3 = axes(a)
    tmp = map(z -> first(z) - HexagonalIndex(last(z)), zip(HexagonalIndices(a), Iterators.product(a1, a2, a3)))
    @test all(I -> I == zero(HexagonalIndex),tmp)
end