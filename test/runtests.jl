using Cclib
using PythonCall
using Test
using AtomsBase



@testset "Cclib.jl" begin

    # Check that input is read correctly
    @test ccread("./data/uracil_two.xyz")["natom"] == 12
    @test ccread("./data/uracil_two.xyz")["atomnos"] == [7, 6, 1, 8, 7, 6, 8, 6, 6, 1, 1, 1]
    @test ccread("./data/uracil_two.xyz")["atomcoords"] == [5.435 4.091 6.109 3.647 3.253 3.636 2.79 5.065 5.906 2.243 5.448 7.003;
                                                                 5.42432 4.08846 6.05396 3.68445 3.24195 3.62987 2.83542 5.0864 5.91213 2.2534 5.42415 6.9915;;;
                                                                 3.248 3.266 3.347 3.394 3.118 2.955 2.842 2.953 3.101 3.138 2.833 3.119;
                                                                 3.24732 3.26356 3.354 3.39863 3.11963 2.96568 2.83961 2.95832 3.09904 3.12801 2.83814 3.10206;;;
                                                                 -0.916 -0.635 -0.144 0.495 -1.717 -3.039 -3.923 -3.239 -2.202 -1.514 -4.258 -2.345;
                                                                 -0.9432 -0.64127 -0.15563 0.50851 -1.70419 -3.0054 -3.9297 -3.25044 -2.21101 -1.51035 -4.27067 -2.32366]

    # Check that it handles unsupported files correctly
    @test isnothing(ccread("./data/invalid_file.txt"))
    @test isnothing(ccread("./data/"))

    # Check AtomsBase Integration
    @test get_atom_objects("./data/uracil_two.xyz")[1] |> atomic_number == 7
    @test get_atom_objects("./data/uracil_two.xyz")[1] |> atomic_symbol == :N
    @test get_atom_objects("./data/uracil_two.xyz")[6] |> atomic_number == 6
    @test get_atom_objects("./data/uracil_two.xyz")[6] |> atomic_symbol == :C

end
