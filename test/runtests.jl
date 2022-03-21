using Cclib
using Test

@testset "Cclib.jl" begin
    @testset "API surface" begin
        @test Cclib.__version__ == "1.7.1"

        @testset "Checking the exported symbols are available" begin
            for s in [:__version__, :parser, :progress, :method, :bridge, :io,
                :test, :ccopen, :ccwrite]
                @test @isdefined s
            end
        end

        @testset "Accessing available parsers" begin
            for p in [:ADF, :DALTON, :FChk, :GAMESS, :GAMESSUK, :Gaussian, :Jaguar,
                :Molcas, :Molpro, :MOPAC, :NWChem, :ORCA, :Psi3, :Psi4,
                :QChem, :Turbomole]
                @test hasproperty(parser, p)
            end
        end

        @testset "Accessing available methods" begin
            for m in [:Bader, :Bickelhaupt, :CDA, :CSPA, :DDEC6, :Density,
                :Electrons, :FragmentAnalysis, :Hirshfeld, :LPA, :MBO,
                :Moments, :MPA, :Nuclear, :OPA, :Orbitals, :Stockholder,
                :Volume]
                @test hasproperty(method, m)
            end
        end

        @testset "Accessing available IO utilities" begin
            for u in [:CJSONReader, :CJSONWriter, :CML, :MOLDEN, :WFXWriter,
                :XYZReader, :XYZWriter]
                @test hasproperty(io, u)
            end

            for u in [:ccframe, :ccopen, :ccread, :ccwrite, :URL_PATTERN]
                @test hasproperty(io, u)
            end
        end
    end

    @testset "Usage" begin
        # An example log file.
        filename = "water.out"

        @testset "Parsing a log file with ccopen and checking some attributes" begin
            parser = ccopen(filename)
            data = parser.parse()

            for a in [:atomcharges, :atomcoords, :atommasses, :atomnos, :charge,
                :coreelectrons, :enthalpy, :entropy, :freeenergy, :geotargets,
                :geovalues, :grads, :homos, :metadata, :moenergies, :moments,
                :mult, :natom, :nbasis, :nmo, :optdone, :pressure, :scfenergies,
                :scftargets, :scfvalues, :temperature, :vibdisps, :vibfreqs,
                :vibirs, :zpve]
                @test hasproperty(data, a)
            end
        end

        @testset "Parsing a log file with ccread and checking some values" begin
            data = io.ccread(filename)

            @test data.natom == 3
            @test data.nmo == 7
            @test data.atomcoords[1, :, :] == [0.0 0.0 0.0; 0.0 1.0 0.0; 0.0 0.0 1.0]
        end
    end
end
