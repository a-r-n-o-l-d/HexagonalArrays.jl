#using Base: @propagate_inbounds

struct HexagonalArray{T} <: AbstractArray{T,3} #HexagonalLattice???
    data::AbstractArray{T,3}
    d_unit
    # CartesianAxes
end

hexdata(A::HexagonalArray) = A.data

Base.size(A::HexagonalArray) = size(A.data)

Base.@propagate_inbounds Base.getindex(A::HexagonalArray, I::HexagonalIndex) = A.data[I.I...]

Base.@propagate_inbounds Base.setindex!(A::HexagonalArray, v, I::HexagonalIndex) = (A.data[I.I...] = v)

Base.@propagate_inbounds Base.getindex(A::HexagonalArray, idxs::Int...) = A.data[idxs...]

Base.@propagate_inbounds Base.setindex!(A::HexagonalArray, v, idxs::Int...) = (A.data[idxs...] = v)

hexzeros(T::Type, nrow, ncol, d_unit) = HexagonalArray(zeros(T, nrow, ncol, 2), d_unit)

hexzeros(nrow, ncol, d_unit) = HexagonalArray(zeros(Float64, nrow, ncol, 2), d_unit)

hexones(T::Type, nrow, ncol, d_unit) = HexagonalArray(ones(T, nrow, ncol, 2), d_unit)

hexones(nrow, ncol, d_unit) = HexagonalArray(ones(Float64, nrow, ncol, 2), d_unit)
