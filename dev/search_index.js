var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = HexagonalArrays","category":"page"},{"location":"#HexagonalArrays","page":"Home","title":"HexagonalArrays","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for HexagonalArrays.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [HexagonalArrays]","category":"page"},{"location":"#HexagonalArrays.HexagonalIndex","page":"Home","title":"HexagonalArrays.HexagonalIndex","text":"HexagonalIndex(i, j, k)   -> I\nHexagonalIndex((i, j, k)) -> I\n\nCreate an hexagonal index I in Hexagonal Efficient Coordinate System (HECS),  which is used for indexing an hexagonal array A.\n\nIn HECS a point on an hexagonal grid is represented by three coordinates  (i j k) in mathbbZ^* times mathbbZ^* times 1 2. You should note that the original HECS indexing is adapted to the Julia indexing  system (column major and 1-based indexing). Hence, i corresponds to the row  number, j to the column number and k to the column parity (i.e. when  k = 1 you access to an odd column, and when k = 2 you access to an even  column).\n\nIn HECS space four operators are defined for vector arithmetic :\n\naddition I_1 + I_2\nnegation -I\nsubtraction I_1 - I_2 = I_1 + (-I_2)\nscalar multiplication s * I s in mathbbN and -s * I = s * (-I)\n\nThe Julia operators +, - and * are extended for these four operations.\n\nExamples\n\njulia> I1 = HexagonalIndex(1, 2, 1)\nHexagonalIndex((1, 2, 1))\n\njulia> I2 = HexagonalIndex(3, 1, 1)\nHexagonalIndex((3, 1, 1))\n\njulia> I1 + I2\nHexagonalIndex((4, 3, 1))\n\njulia> I1 - I2\nHexagonalIndex((-2, 1, 1))\n\njulia> 3 * I1\nHexagonalIndex((3, 6, 1))\n\n\n\n\n\n","category":"type"},{"location":"#HexagonalArrays.heuclidean-Tuple{HexagonalIndex, HexagonalIndex, Any}","page":"Home","title":"HexagonalArrays.heuclidean","text":"\n\n\n\n","category":"method"},{"location":"#HexagonalArrays.to_cartesian-Tuple{HexagonalIndex, Any}","page":"Home","title":"HexagonalArrays.to_cartesian","text":"to_cartesian(I, unitd) -> (x, y)\n\nReturn the cartesian coordinates (x, y) of the hexagonal index I. The  upper-left hexagon of the hexagonal grid is assumed to have cartesian  coordinates (0,0). unitd is the unit distance between two adjacent hexagons.\n\n\n\n\n\n","category":"method"}]
}
