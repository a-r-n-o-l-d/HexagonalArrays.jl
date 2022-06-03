const hsq3 = sqrt(3) / 2
const sq3 = sqrt(3)
const d_unit_area = sqrt(2 / sqrt(3))

function hexagon_vertices(x, y, d)
    w = d / sq3
    (x - w    , y), 
    (x - w / 2, y + d / 2), 
    (x + w / 2, y + d / 2),
    (x + w    , y),
    (x + w / 2, y - d / 2),
    (x - w / 2, y - d / 2)
end