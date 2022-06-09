macro neighborhood(I, radius, N, body)
    quote
        local i, j, k = Tuple($(esc(I)))
        local Δj = $(esc(radius)) >> 1
        for oj in -Δj:Δj
            local Δi = $(esc(radius)) - abs(oj)
            for oi in -Δi:Δi
                $(esc(N)) = HexagonalIndex(i + oi, j + oj, k)
                $(esc(body))
            end
        end
        local i = i + k - 2
        local j = j + k - 2
        local Δj = ($(esc(radius)) + 1) >> 1
        for oj in -Δj + 1:Δj
            local Δi = trunc(Int, $(esc(radius)) - abs(oj - 0.5) - 0.5)
            for oi in -Δi:Δi + 1
                $(esc(N)) = HexagonalIndex(i + oi, j + oj, 3 - k)
                $(esc(body))
            end
        end
    end
end

function _neighborhood(I::HexagonalIndex)
    r, c, a = I.I
    r1, c1 = r + a - 2, c + a - 2
    r2, c2 = r1 + 1, c1 + 1
    a_ = 3 - a
    (r - 1, c, a),
    (r,     c, a),
    (r + 1, c, a),
    (r1,    c1, a_),
    (r2,    c1, a_),
    (r1,    c2, a_),
    (r2,    c2, a_)
end

macro neighborhood(I, N, body)
    quote
        for n in _neighborhood($(esc(I)))
            $(esc(N)) = HexagonalIndex(n)
            $(esc(body))
        end
    end
end

macro neighborhood(radius, N, body)
    :(@neighborhood(zero(HexagonalIndex), $radius, $N, $body))
end