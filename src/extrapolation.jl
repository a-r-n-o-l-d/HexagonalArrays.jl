abstract type AbstractExtrapolation end

_checkbounds(ex::AbstractExtrapolation, I::HexagonalIndex) = checkbounds(Bool, ex.A.data, I.I...)

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

struct Constant <: AbstractExtrapolation
    A::HexagonalArray
    value
end

@inline Base.getindex(ex::Constant, I::HexagonalIndex) =
    _checkbounds(ex, I) ? (@inbounds ex.A[I]) : ex.value

@inline Base.getindex(ex::Constant, inds::Int...) = 
    _checkbounds(ex, inds...) ? (@inbounds ex.A[inds]) : ex.value


struct Periodic <: AbstractExtrapolation
    A::HexagonalArray
end

@inline Base.getindex(ex::Periodic, I::HexagonalIndex) =
    _checkbounds(ex, I) ? (@inbounds ex.A[I]) : (@inbounds ex.A[_periodic_inds(I.I..., ex)])

@inline Base.getindex(ex::Periodic, inds::Int...) = 
    _checkbounds(ex, inds...) ? (@inbounds ex.A[inds]) : (@inbounds ex.A[_periodic_inds(inds..., ex)])

function _periodic_inds(i, j, k, ex)
    nr, nc, _ = size(ex.A)
    if i < 1
        i = nr + i
    elseif i > nr 
        i = i - nr
    end
    if j < 1
        j = nc - j
    elseif j > nc
        j = j - nc
    end
    HexagonalIndex(i, j, k)
end

struct Symmetric <: AbstractExtrapolation
    A::HexagonalArray
end

@inline Base.getindex(ex::Symmetric, I::HexagonalIndex) =
    _checkbounds(ex, I) ? (@inbounds ex.A[I]) : (@inbounds ex.A[_symmetric_inds(I.I..., ex)])

@inline Base.getindex(ex::Symmetric, inds::Int...) = 
    _checkbounds(ex, inds...) ? (@inbounds ex.A[inds]) : (@inbounds ex.A[_symmetric_inds(inds..., ex)])

function _symmetric_inds(i, j, k, ex)
    nr, nc, _ = size(ex.A)
    if i < 1
        i = 3 - i - k
    elseif i > nr 
        i = 2 * (nr + 1) - i - k
    end
    if j < 1
        j = 3 - j - k
    elseif j > nc
        j = 2 * (nc + 1) - j - k
    end
    HexagonalIndex(i, j, k)
end