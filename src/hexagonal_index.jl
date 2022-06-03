struct HexagonalIndex <: Base.AbstractCartesianIndex{3}
    I::NTuple{3,Int}
end

HexagonalIndex(i, j, k) = HexagonalIndex((i, j, k))

indices(I::HexagonalIndex) = I.I

# Addition
function Base.:+(I1::HexagonalIndex, I2::HexagonalIndex)
    i1, j1, k1 = indices(I1)
    i2, j2, k2 = indices(I2)
    k1 = Bool(I1.I[3] - 1)
    k2 = Bool(I2.I[3] - 1)
    HexagonalIndex(i1 + i2 + (k1 && k2) - 1,
                   j1 + j2 + (k1 && k2) - 1,
                   k1 ⊻ k2 + 1)
end

# Negation
function Base.:-(I::HexagonalIndex)
    i, j, k = indices(I)
    HexagonalIndex(-i - k + 2, -j - k + 2, k)
end

# Subtraction
Base.:-(I1::HexagonalIndex, I2::HexagonalIndex) = I1 + (-I2)

# Scalar multiplication 
function Base.:*(α::Int, I::HexagonalIndex)
    α < 0 && return (-α) * (-I)
    i, j, k = indices(I)
    HexagonalIndex((i - 1) * α + (k - 1) * (α >> 1) + 1,
                   (j - 1) * α + (k - 1) * (α >> 1) + 1,
                   mod(α * (k - 1), 2) + 1)
end

Base.:*(I::HexagonalIndex, α::Int) = *(α::Int, I::HexagonalIndex)