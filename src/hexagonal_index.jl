struct HexagonalIndex <: Base.AbstractCartesianIndex{3}
    I::NTuple{3,Int}
end

HexagonalIndex(i, j, k) = HexagonalIndex((i, j, k))

indices(I::HexagonalIndex) = I.I

Base.zero(::HexagonalIndex) = HexagonalIndex(0, 0, 1)
Base.zero(::Type{HexagonalIndex}) = HexagonalIndex(0, 0, 1)
Base.one(::HexagonalIndex) = HexagonalIndex(1, 1, 1)
Base.one(::Type{HexagonalIndex}) = HexagonalIndex(1, 1, 1)

# Addition
function Base.:+(I1::HexagonalIndex, I2::HexagonalIndex)
    i1, j1, k1 = indices(I1)
    i2, j2, k2 = indices(I2)
    k1 = Bool(k1 - 1)
    k2 = Bool(k2 - 1)
    HexagonalIndex(i1 + i2 + (k1 && k2),
                   j1 + j2 + (k1 && k2),
                   k1 ⊻ k2 + 1)
end

# Negation
function Base.:-(I::HexagonalIndex)
    i, j, k = indices(I)
    HexagonalIndex(-i - k + 1, -j - k + 1, k)
end

# Subtraction
Base.:-(I1::HexagonalIndex, I2::HexagonalIndex) = I1 + (-I2)

# Scalar multiplication 
function Base.:*(s::Int, I::HexagonalIndex)
    s < 0 && return (-s) * (-I)
    i, j, k = indices(I)
    HexagonalIndex(i * s + (k - 1) * (s >> 1),
                   j * s + (k - 1) * (s >> 1),
                   mod(s * (k - 1), 2) + 1)
end

Base.:*(I::HexagonalIndex, s::Int) = *(s::Int, I::HexagonalIndex)