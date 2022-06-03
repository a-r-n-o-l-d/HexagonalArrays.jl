const hsq3 = sqrt(3) / 2
const sq3 = sqrt(3)
const d_unit_area = sqrt(2 / sqrt(3))

hexcount(n) = 3 * n * (n + 1) + 1 # https://oeis.org/A003215

function hexvertices(x, y, d)
    w = d / sq3
    (x - w    , y), 
    (x - w / 2, y + d / 2), 
    (x + w / 2, y + d / 2),
    (x + w    , y),
    (x + w / 2, y - d / 2),
    (x - w / 2, y - d / 2)
end