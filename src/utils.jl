const hsq3 = sqrt(3) / 2
const sq3 = sqrt(3)
const d_unit_area = sqrt(2 / sqrt(3))

hcount(n) = 3 * n * (n + 1) + 1 # https://oeis.org/A003215

function hvertices(x, y, d)
    w = d / sq3
    (x - w    , y), 
    (x - w / 2, y + d / 2), 
    (x + w / 2, y + d / 2),
    (x + w    , y),
    (x + w / 2, y - d / 2),
    (x - w / 2, y - d / 2)
end

hvertices(I, d) = hvertices(to_cartesian(I, d)..., d)


