@testset "HexagonalNeighborhood" begin
    radius = 2
    d = []
    @neighborhood HexagonalIndex(0, 0, 1) radius N begin 
        push!(d, euclidean(N, HexagonalIndex(0, 0, 1), 1))
    end
    @test all(@. d <= radius)
end