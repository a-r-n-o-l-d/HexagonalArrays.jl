#using Base: @propagate_inbounds

struct HexagonalArray{T} <: AbstractArray{T,3} #HexagonalLattice???
    data::AbstractArray{T,3}
    d_unit
    # CartesianAxes
end

hexdata(H::HexagonalArray) = H.data

Base.size(H::HexagonalArray) = size(H.data)

Base.@propagate_inbounds Base.getindex(H::HexagonalArray, I::HexagonalIndex) = H.data[I.I...]

Base.@propagate_inbounds Base.setindex!(H::HexagonalArray, v, I::HexagonalIndex) = (H.data[I.I...] = v)

Base.@propagate_inbounds Base.getindex(H::HexagonalArray, idxs::Int...) = H.data[idxs...]

Base.@propagate_inbounds Base.setindex!(H::HexagonalArray, v, idxs::Int...) = (H.data[idxs...] = v)

#Base.getindex(H::HexagonalArray, i::Int) = data(H)[i]

#Base.getindex(H::HexagonalArray, I::Vararg{Int,3}) = data(H)[I...]

#Base.getindex(H::HexagonalArray) = data(H)[]

#Base.getindex(H::HexagonalArray, c::Vararg{Union{Colon, Int},3}) = datas(H)[c...]
    #parent_call(x -> getindex(x, c...), A)
#=
function Base.setindex!(H::HexagonalArray, val, I::HexagonalIndex)
    datas(H)[I.I...] = val
    H
end

function Base.setindex!(H::HexagonalArray, val, i::Int)
    datas(H)[i] = val
    H
end

function Base.setindex!(H::HexagonalArray, val, I::Vararg{Int,3})
    datas(H)[I...] = val
    H
end
=#


