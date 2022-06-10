# Constructors
@test (3, 3, 2) == Tuple(HexagonalIndex(3, 3, 2))
@test (1, 1, 1) == Tuple(one(HexagonalIndex))
@test (0, 0, 1) == Tuple(zero(HexagonalIndex))
@test zero(HexagonalIndex) == zero(HexagonalIndex(3, 3, 2))
@test one(HexagonalIndex) == one(HexagonalIndex(3, 3, 2))
@test_throws MethodError HexagonalIndex(3, 3, 2, 4)
#@test_throws ArgumentError HexagonalIndex((3, 3, 4))

# Operators
@test one(HexagonalIndex) + one(HexagonalIndex) == 2 * one(HexagonalIndex)
@test one(HexagonalIndex) - one(HexagonalIndex) == zero(HexagonalIndex)
@test -2 * one(HexagonalIndex) == -one(HexagonalIndex) * 2
@test HexagonalIndex(3, 3, 2) == HexagonalIndex(3, 3, 2)

# Functions
@test to_cartesian(one(HexagonalIndex), 1) == (0.0, 0.0)
@test heuclidean(HexagonalIndex(1,1,1), HexagonalIndex(2,1,1), 1) == 1.0
