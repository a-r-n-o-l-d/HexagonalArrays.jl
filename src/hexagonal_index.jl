struct HexagonalIndex #<: Base.AbstractCartesianIndex{3}
    I::NTuple{3,Int}
end

HexagonalIndex(i, j, k) = HexagonalIndex((i, j, k))

HexagonalIndex(I::CartesianIndex{3}) = HexagonalIndex(Tuple(I))

Base.Tuple(I::HexagonalIndex) = I.I

Base.zero(::HexagonalIndex) = HexagonalIndex(0, 0, 1)

Base.zero(::Type{HexagonalIndex}) = HexagonalIndex(0, 0, 1)

Base.one(::HexagonalIndex) = HexagonalIndex(1, 1, 1) #HexagonalIndex(1, 1, 2)???

Base.one(::Type{HexagonalIndex}) = HexagonalIndex(1, 1, 1) #HexagonalIndex(1, 1, 2)???

Base.:(==)(I1::HexagonalIndex, I2::HexagonalIndex) = I1.I == I2.I

# Addition
function Base.:(+)(I1::HexagonalIndex, I2::HexagonalIndex)
    i1, j1, k1 = Tuple(I1)
    i2, j2, k2 = Tuple(I2)
    k1 = Bool(k1 - 1)
    k2 = Bool(k2 - 1)
    HexagonalIndex(i1 + i2 + (k1 && k2),
                   j1 + j2 + (k1 && k2),
                   k1 ⊻ k2 + 1)
end

# Negation
function Base.:(-)(I::HexagonalIndex)
    i, j, k = Tuple(I)
    HexagonalIndex(-i - k + 1, -j - k + 1, k)
end

# Subtraction
Base.:(-)(I1::HexagonalIndex, I2::HexagonalIndex) = I1 + (-I2)

# Scalar multiplication 
function Base.:(*)(s::Int, I::HexagonalIndex)
    s < 0 && return (-s) * (-I)
    i, j, k = Tuple(I)
    HexagonalIndex(i * s + (k - 1) * (s >> 1),
                   j * s + (k - 1) * (s >> 1),
                   mod(s * (k - 1), 2) + 1)
end

Base.:(*)(I::HexagonalIndex, s::Int) = *(s::Int, I::HexagonalIndex)

# Cartesian coordinates => utils
function to_cartesian(I::HexagonalIndex, d_unit) #to_cartesian(I::HexagonalIndex, H::HexagonalArray)
    i, j, k = Tuple(I)
    x = d_unit * sq3 * (k / 2 + j - 3 / 2) # + 1 # x - 2 * nc * d_unit
    y = d_unit * (k / 2 + i - 3 / 2)       # + 1 # (nr * d_unit + 0.5) - y 
    x, y
end

# Euclidean distance => utils
function euclidean(I1::HexagonalIndex, I2::HexagonalIndex, d_unit)
    i1, j1, k1 = Tuple(I1)
    i2, j2, k2 = Tuple(I2)
    k = (k1 - k2) / 2
    d_unit * sqrt(3 * (k + j1 - j2)^2 + (k + i1 - i2)^2)
end
