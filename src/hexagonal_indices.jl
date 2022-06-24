struct HexagonalIndices{R<:OrdinalRange} <: AbstractArray{HexagonalIndex,3}
    rowrng::R #rename to irng
    colrng::R #rename to jrng
    arng::R #rename to krng
end

HexagonalIndices(A::HexagonalArray) = HexagonalIndices(axes(A)...)

@inline function Base.iterate(hi::HexagonalIndices)
    I = first(hi)
    I, I
end

# avoid calling Base.IteratorsMD.__inc, make a hard copy here, in case of redifinition
@inline function Base.iterate(hi::HexagonalIndices, state)
    valid, I = Base.IteratorsMD.__inc(state.I, (hi.rowrng, hi.colrng, hi.arng))
    valid || return nothing
    return HexagonalIndex(I...), HexagonalIndex(I...)
end

@inline Base.size(hi::HexagonalIndices) = (length(hi.rowrng), length(hi.colrng), length(hi.arng))

@inline Base.length(hi::HexagonalIndices) = length(hi.rowrng) * length(hi.colrng) * length(hi.arng)

@inline Base.first(hi::HexagonalIndices) = HexagonalIndex(first(hi.rowrng), first(hi.colrng), first(hi.arng))

@inline Base.last(hi::HexagonalIndices) = HexagonalIndex(last(hi.rowrng), last(hi.colrng), last(hi.arng))

@inline function Base.getindex(hi::HexagonalIndices, i, j, k)
    @boundscheck checkbounds(hi, i, j, k)
    @inbounds idx = (getindex(hi.rowrng, i), getindex(hi.rowrng, j), getindex(hi.arng, k))
    HexagonalIndex(idx)
end

function Base.:(:)(I::HexagonalIndex, J::HexagonalIndex)
    rg = map((i, j) -> i:j, Tuple(I), Tuple(J))
    HexagonalIndices(rg...)
end

function Base.:(:)(I::HexagonalIndex, S::HexagonalIndex, J::HexagonalIndex)
    rg = map((i, s, j) -> i:s:j, Tuple(I), Tuple(S), Tuple(J))
    HexagonalIndices(rg...)
end

#=
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
=#
