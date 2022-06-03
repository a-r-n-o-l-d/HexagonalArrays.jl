struct HexagonalIndex <: Base.AbstractCartesianIndex{3}
    I::NTuple{3,Int}
end

HexagonalIndex(i, j, k) = HexagonalIndex((i, j, k))

indices(I::HexagonalIndex) = I.I

