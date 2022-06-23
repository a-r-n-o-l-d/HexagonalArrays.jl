"""
    HexagonalIndex(i, j, k)   -> I
    HexagonalIndex((i, j, k)) -> I

Creates an hexagonal index `I` in Hexagonal Efficient Coordinate System
([HECS](https://en.wikipedia.org/wiki/Hexagonal_Efficient_Coordinate_System)), 
which is used for indexing an hexagonal array `A`.

In HECS a point on an hexagonal grid represented by three coordinates 
``(i, j, k) \\in \\mathbb{Z}^{*} \\times \\mathbb{Z}^{*} \\times \\{1, 2\\}``.
You should note that the original HECS indexing is adapted to the Julia indexing 
system (column major and 1-based indexing). Hence, ``i`` corresponds to the row 
number, ``j`` to the column number and ``k`` to the column parity (i.e. when 
``k = 1`` you access to an odd column, and when ``k = 2`` you access to an even 
column).

In HECS space four operators are defined for vector arithmetic :

- addition ``I_1 + I_2``
- negation ``-I``
- subtraction ``I_1 - I_2 = I_1 + (-I_2)``
- scalar multiplication ``s * I, s \\in \\mathbb{N}`` and ``-s * I = s * (-I)``

The Julia operators `+`, `-` and `*` are extended for these four operations.

# Examples

```julia
julia> I1 = HexagonalIndex(1, 2, 1)
HexagonalIndex((1, 2, 1))

julia> I2 = HexagonalIndex(3, 1, 1)
HexagonalIndex((3, 1, 1))

julia> I1 + I2
HexagonalIndex((4, 3, 1))

julia> I1 - I2
HexagonalIndex((-2, 1, 1))

julia> 3 * I1
HexagonalIndex((3, 6, 1))
```
"""
struct HexagonalIndex
    I::NTuple{3,Int}
end

function HexagonalIndex(i, j, k)
    HexagonalIndex((i, j, k)) #k in 1:2 || throw(ArgumentError("Third index must be in 1:2.")) # seems to cause type unstability
end

HexagonalIndex(I::CartesianIndex{3}) = HexagonalIndex(Tuple(I))

Base.Tuple(I::HexagonalIndex) = I.I

Base.zero(::HexagonalIndex) = HexagonalIndex(0, 0, 1)

Base.zero(::Type{HexagonalIndex}) = HexagonalIndex(0, 0, 1)

Base.one(::HexagonalIndex) = HexagonalIndex(1, 1, 1) #oneunit

Base.one(::Type{HexagonalIndex}) = HexagonalIndex(1, 1, 1)

Base.:(==)(I1::HexagonalIndex, I2::HexagonalIndex) = Tuple(I1) == Tuple(I2)

# Addition
function Base.:(+)(I1::HexagonalIndex, I2::HexagonalIndex)
    i1, j1, k1 = Tuple(I1)
    i2, j2, k2 = Tuple(I2)
    kk1, kk2 = Bool(k1 - 1), Bool(k2 - 1)
    HexagonalIndex(i1 + i2 + (kk1 && kk2),
                   j1 + j2 + (kk1 && kk2),
                   kk1 ⊻ kk2 + 1)
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
function heuclidean(I1::HexagonalIndex, I2::HexagonalIndex, d_unit)
    i1, j1, k1 = Tuple(I1)
    i2, j2, k2 = Tuple(I2)
    k = (k1 - k2) / 2
    d_unit * sqrt(3 * (k + j1 - j2)^2 + (k + i1 - i2)^2)
end
