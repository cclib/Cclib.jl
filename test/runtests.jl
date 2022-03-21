using Cclib
using Test

@testset "Cclib.jl" begin
    filename = "water.out"

    @testset "Parsing a log file with ccopen" begin
        parser = io.ccopen(filename)
        data = parser.parse()

        @test data.natom == 3
        @test data.nmo == 7
        @test data.atomcoords[1, :, :] == [0.0 0.0 0.0; 0.0 1.0 0.0; 0.0 0.0 1.0]
    end

    @testset "Parsing a log file with ccread" begin
        data = io.ccread(filename)

        @test data.natom == 3
        @test data.nmo == 7
        @test data.atomcoords[1, :, :] == [0.0 0.0 0.0; 0.0 1.0 0.0; 0.0 0.0 1.0]
    end
end
