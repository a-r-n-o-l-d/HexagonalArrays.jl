
# Constructor
dat = rand(2, 2, 2)
a = HexagonalArray(dat, d_unit_area)
@test hexdata(a) == dat
@test sum(hexzeros(Int, 3, 4, 1)) == 0
@test sum(hexzeros(3, 4, 1)) == 0.0
@test sum(hexones(Int, 3, 4, 1)) == 3 * 4 * 2
@test sum(hexones(3, 4, 1)) == 3 * 4 * 2

@test size(a) == size(dat)

# Indexing
a[1, 1, 1] = 1
a[HexagonalIndex(2, 1, 1)] = 2
a[3] = 3.0
@test a[1] == 1.0
@test a[2] == 2.0
@test a[HexagonalIndex(1, 2, 1)] == 3.0
@test_throws BoundsError a[1,1]

# HexagonalIndices
a = HexagonalArray(rand(2, 2, 2), d_unit_area)
a1, a2, a3 = axes(a)
zz = zip(HexagonalIndices(a), HexagonalIndex.(Iterators.product(a1, a2, a3)))
@test all(z -> first(z) - last(z) == zero(HexagonalIndex), zz)
a = hexzeros(8, 4, 1)
a = hexzeros(8, 4, 1)
for I in HexagonalIndex(1, 1, 1):HexagonalIndex(2, 2, 1):HexagonalIndex(8, 4, 2)
    a[I] = 42
end
for I in HexagonalIndices(a)
    i, j, k = Tuple(I)
    if isodd(i) && isodd(j)
        @test a[I] == 42
    else
        @test a[I] == 0
    end
end
for I in HexagonalIndex(1, 1, 1):HexagonalIndex(8, 4, 2)
    a[I] = 1
end
@test sum(a) == prod(size(a))