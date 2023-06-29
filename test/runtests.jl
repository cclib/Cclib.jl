using Cclib
using Test


@testset "Cclib.jl" begin
    @test ccread("./test/data/uracil_two.xyz")["natom"] == 12
end

