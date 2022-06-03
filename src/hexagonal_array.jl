struct HexagonalArray{T} <: AbstractArray{T,3} #HexagonalLattice???
    datas::T
    d_unit
    # CartesianAxes
end

datas(H::HexagonalArray) = H.datas

Base.size(H::HexagonalArray) = size(datas(H))

Base.getindex(H::HexagonalArray, I::HexagonalIndex) = datas(H)[I.I...]

Base.getindex(H::HexagonalArray, i::Int) = datas(H)[i]

Base.getindex(H::HexagonalArray, I::Vararg{Int,3}) = datas(H)[I...]

Base.getindex(H::HexagonalArray) = datas(H)[]

function Base.setindex!(H::HexagonalArray, val, I::Vararg{Int,3})
    datas(H)[I...] = val
    H
end

function Base.setindex!(H::HexagonalArray, val, i::Int)
    datas(H)[i] = val
    H
end

function Base.setindex!(H::HexagonalArray, val, I::HexagonalIndex)
    datas(H)[I.I...] = val
    H
end