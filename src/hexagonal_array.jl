#using Base: @propagate_inbounds
# nrow, ncol

struct HexagonalArray{T} <: AbstractArray{T,3}
    array::Array{T,3}
    d_unit
    # CartesianAxes
end

harray(A::HexagonalArray) = A.array

hzeros(T::Type, nrow, ncol, d_unit) = HexagonalArray(zeros(T, nrow, ncol, 2), d_unit)

hzeros(nrow, ncol, d_unit) = HexagonalArray(zeros(Float64, nrow, ncol, 2), d_unit)

hones(T::Type, nrow, ncol, d_unit) = HexagonalArray(ones(T, nrow, ncol, 2), d_unit)

hones(nrow, ncol, d_unit) = HexagonalArray(ones(Float64, nrow, ncol, 2), d_unit)

Base.size(A::HexagonalArray) = size(harray(A))

Base.@propagate_inbounds Base.getindex(A::HexagonalArray, I::HexagonalIndex) = harray(A)[I.I...]

Base.@propagate_inbounds Base.setindex!(A::HexagonalArray, v, I::HexagonalIndex) = (harray(A)[I.I...] = v)

Base.@propagate_inbounds Base.getindex(A::HexagonalArray, inds::Int...) = harray(A)[inds...] #::Vararg{3, Int}

Base.@propagate_inbounds Base.setindex!(A::HexagonalArray, v, inds::Int...) = (harray(A)[inds...] = v)


struct HexagonalIndices
    ci::CartesianIndices
end

HexagonalIndices(A::HexagonalArray) = HexagonalIndices(CartesianIndices(harray(A)))

@inline function Base.iterate(iter::HexagonalIndices)
    iterfirst = HexagonalIndex(first(iter.ci))
    iterfirst, iterfirst
end

@inline function Base.iterate(iter::HexagonalIndices, state)
    c = iterate(iter.ci, CartesianIndex(state.I))
    isnothing(c) && return nothing
    c1, c2 = c
    HexagonalIndex(c1), HexagonalIndex(c2)
end

Base.length(hi::HexagonalIndices) = length(hi.ci)

Base.first(hi::HexagonalIndices) = first(hi.ci)

Base.last(hi::HexagonalIndices) = last(hi.ci)

# Definition of firstindex and getindex to enable parallelisation
Base.firstindex(hi::HexagonalIndices) = 1

Base.getindex(hi::HexagonalIndices, i) = getindex(hi.ci, i)

function Base.:(:)(I::HexagonalIndex, J::HexagonalIndex)
    #Ic = CartesianIndex(Tuple(I))
    #Jc = CartesianIndex(Tuple(J))
    rg = map((i, j) -> i:j, Tuple(I), Tuple(J))
    HexagonalIndices(CartesianIndices(rg))
end

function Base.:(:)(I::HexagonalIndex, S::HexagonalIndex, J::HexagonalIndex)
    rg = map((i, s, j) -> i:s:j, Tuple(I), Tuple(S), Tuple(J))
    HexagonalIndices(CartesianIndices(rg))
end
