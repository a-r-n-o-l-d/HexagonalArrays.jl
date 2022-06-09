abstract type AbstractExtrapolation end

_checkbounds(ex::AbstractExtrapolation, I::HexagonalIndex) = checkbounds(Bool, ex.A, I.I...)

_checkbounds(ex::AbstractExtrapolation, inds::Int...) = _checkbounds(ex, HexagonalIndex(inds))

struct Replicate <: AbstractExtrapolation
   A::HexagonalArray
end

@inline Base.getindex(ex::Replicate, I::HexagonalIndex) =
    _checkbounds(ex, I) ? (@inbounds ex.A[I]) : (@inbounds ex.A[_replicate_inds(I.I..., ex)])

@inline Base.getindex(ex::Replicate, inds::Int...) =
    _checkbounds(ex, inds...) ? (@inbounds ex.A[inds]) : (@inbounds ex.A[_replicate_inds(inds..., ex)])

function _replicate_inds(i, j, k, ex)
    nr, nc, _ = size(ex.A)
    if i < 1
        i = 1
    elseif i > nr 
        i = nr
    end
    if j < 1
        j, k = 1, 1
    elseif j > nc
        j, k = nc, 2
    end
    HexagonalIndex(i, j, k)
end

