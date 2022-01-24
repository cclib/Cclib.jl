using Cclib
using Test

@testset "Cclib.jl" begin
    filename = "water.out"

    @testset "Parsing a log file with ccopen" begin
        parser = cclib.io.ccopen(filename)
        data = parser.parse()

        @test data.natom == 3
        @test data.nmo == 7
        @test data.atomcoords[1, :, :] == [0.0 0.0 0.0; 0.0 1.0 0.0; 0.0 0.0 1.0]
    end

    @testset "Parsing a log file with ccread" begin
        data = cclib.io.ccread(filename)

        @test data.natom == 3
        @test data.nmo == 7
        @test data.atomcoords[1, :, :] == [0.0 0.0 0.0; 0.0 1.0 0.0; 0.0 0.0 1.0]
    end
end
