using Cclib
using PythonCall
using Unitful
using Test
using AtomsBase



@testset "Cclib.jl" begin
    test_file = "./data/uracil_two.xyz"
    test_ccdata = ccread(test_file)

    test_system_file = "./data/calculation_methods/bader/water_mp2.out"
    test_system_ccdata = ccread(test_system_file)

    test_geometry = """
    7\t5.42432\t3.24732\t-0.9432
    6\t4.08846\t3.26356\t-0.64127
    1\t6.05396\t3.354\t-0.15563
    8\t3.68445\t3.39863\t0.50851
    7\t3.24195\t3.11963\t-1.70419
    6\t3.62987\t2.96568\t-3.0054
    8\t2.83542\t2.83961\t-3.9297
    6\t5.0864\t2.95832\t-3.25044
    6\t5.91213\t3.09904\t-2.21101
    1\t2.2534\t3.12801\t-1.51035
    1\t5.42415\t2.83814\t-4.27067
    1\t6.9915\t3.10206\t-2.32366
    """

    #
    # Test parsing and reading
    #

    # Check that input is read correctly
    @test test_ccdata["natom"] == 12
    @test test_ccdata["atomnos"] == [7, 6, 1, 8, 7, 6, 8, 6, 6, 1, 1, 1]
    @test test_ccdata["atomcoords"] == [5.435 4.091 6.109 3.647 3.253 3.636 2.79 5.065 5.906 2.243 5.448 7.003;
                                        5.42432 4.08846 6.05396 3.68445 3.24195 3.62987 2.83542 5.0864 5.91213 2.2534 5.42415 6.9915;;;
                                        3.248 3.266 3.347 3.394 3.118 2.955 2.842 2.953 3.101 3.138 2.833 3.119;
                                        3.24732 3.26356 3.354 3.39863 3.11963 2.96568 2.83961 2.95832 3.09904 3.12801 2.83814 3.10206;;;
                                        -0.916 -0.635 -0.144 0.495 -1.717 -3.039 -3.923 -3.239 -2.202 -1.514 -4.258 -2.345;
                                        -0.9432 -0.64127 -0.15563 0.50851 -1.70419 -3.0054 -3.9297 -3.25044 -2.21101 -1.51035 -4.27067 -2.32366]

    # Check that it handles unsupported files correctly
    @test_throws ArgumentError ccread("./data/invalid_file.txt")
    @test_throws ArgumentError ccread("./data/")

    # Check that it writes .xyz correctly
    @test getXYZ(test_file) == test_geometry
    @test getXYZ(test_ccdata) == test_geometry
    @test_throws BoundsError getXYZ(test_file, 3)
    @test_throws BoundsError getXYZ(test_ccdata, 3)

    #
    # Check AtomsBase Integration
    #

    # test atom objects
    test_atom_objects = get_atom_objects(test_file)
    @test atomic_number(test_atom_objects[1]) == 7
    @test atomic_symbol(test_atom_objects[1]) == :N
    @test atomic_number(test_atom_objects[6]) == 6
    @test atomic_symbol(test_atom_objects[6]) == :C

    # test systems
    test_box = [[3.0, 0.0, 0.0], [0.0, 3.0, 0.0], [0.0, 0.0, 3.0]]u"Å"
    test_boundary_conditions = [Periodic(), Periodic(), Periodic()]
    test_flexible_system = make_flexible_system(test_system_file, test_box, test_boundary_conditions)
    test_isolated_system = make_isolated_system(test_system_file)

    @test atomic_number(test_flexible_system) == [8, 1, 1]
    @test atomic_number(test_isolated_system) == [8, 1, 1]
    @test update_system(test_isolated_system; prop=5)[:prop] == 5

    #
    # Check calculation methods
    #

    # populations, density, and mbo
    test_calc_file = "./data/Trp_polar.fchk"
    pop_funcs = [cspa, mpa, lpa, bpa]
    for func in pop_funcs
        aoresults, fragresults, fragcharges = func(test_calc_file)
        @test typeof(aoresults) == Array{Float64, 3}
        @test size(aoresults) == (1, 87, 87)

        @test typeof(fragresults) == Array{Float64, 3}
        @test size(fragresults) == (1, 87, 27)

        @test typeof(fragcharges) == Array{Float64, 1}
        @test size(fragcharges) == (27,)
    end

    test_density = density(test_calc_file)
    @test size(test_density) == (1, 87, 87)
    @test typeof(test_density) == Array{Float64, 3}

    test_mbo = mbo(test_calc_file)
    @test size(test_mbo) == (1, 27, 27)
    @test typeof(test_mbo) == Array{Float64, 3}

    # cda
    test_attrs = (
        "./data/calculation_methods/cda/BH3CO-sp.log",
        "./data/calculation_methods/cda/BH3.log",
        "./data/calculation_methods/cda/CO.log"
        )
    donations, bdonations, repulsions = cda(test_attrs...)
    @test typeof(donations) == Matrix{Float64}
    @test size(donations) == (1, 51)

    @test typeof(bdonations) == Matrix{Float64}
    @test size(bdonations) == (1, 51)

    @test typeof(repulsions) == Matrix{Float64}
    @test size(repulsions) == (1, 51)


end
