macro neighborhood(I, radius, N, body)
    quote
        local i, j, k = index($I)
        local Δj = $radius >> 1
        for oj in -Δj:Δj
            local Δi = $radius - abs(oj)
            for oi in -Δi:Δi
                $N = HexagonalIndex(i + oi, j + oj, k)
                $body
            end
        end
        local i = i + k - 2
        local j = j + k - 2
        local Δj = ($radius + 1) >> 1
        for oj in -Δj + 1:Δj
            local Δi = trunc(Int, $radius - abs(oj - 0.5) - 0.5)
            for oi in -Δi:Δi + 1
                $N = HexagonalIndex(i + oi, j + oj, 3 - k)
                $body
            end
        end
    end
end

function _neighborhood1(I::HexagonalIndex)
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
        for n in _neighborhood1($I)
            $N = HexagonalIndex(n)
            $body
        end
    end
end