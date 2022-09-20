#using Base: @propagate_inbounds
# define nrow, ncol
# move HexagonalIndices to its own file
# check type stability

struct HexagonalArray{T} <: AbstractArray{T,3}
    array::Array{T,3}
    unitd
    # CartesianAxes
end

harray(A::HexagonalArray) = A.array

hzeros(T::Type, nrow, ncol, unitd) = HexagonalArray(zeros(T, nrow, ncol, 2), unitd)

hzeros(nrow, ncol, unitd) = HexagonalArray(zeros(Float64, nrow, ncol, 2), unitd)

hones(T::Type, nrow, ncol, unitd) = HexagonalArray(ones(T, nrow, ncol, 2), unitd)

hones(nrow, ncol, unitd) = HexagonalArray(ones(Float64, nrow, ncol, 2), unitd)

Base.size(A::HexagonalArray) = size(harray(A))

Base.@propagate_inbounds Base.getindex(A::HexagonalArray, I::HexagonalIndex) = harray(A)[Tuple(I)...] #change to Tuple(I)

Base.@propagate_inbounds Base.setindex!(A::HexagonalArray, v, I::HexagonalIndex) = (harray(A)[Tuple(I)...] = v)#change to Tuple(I)

Base.@propagate_inbounds Base.getindex(A::HexagonalArray, inds::Int...) = harray(A)[inds...] #change to ::Vararg{3, Int}

Base.@propagate_inbounds Base.setindex!(A::HexagonalArray, v, inds::Int...) = (harray(A)[inds...] = v) #change to ::Vararg{3, Int}
