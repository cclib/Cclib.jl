using Cclib
using Test


@testset "Cclib.jl" begin
    @test Cclib.get_n_atom("./test/data/uracil_two.xyz") == 12
end
