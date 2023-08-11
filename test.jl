using Cclib
using DelimitedFiles
using Fermi

mol = ccread("./test/data/Trp_polar.fchk")
atoms = mol["atomnos"] |>
            x -> string.(x)
coords = mol["atomcoords"][1, :, :]
test_input = hcat(atoms, coords)
b = IOBuffer()
writedlm(b, test_input)
s = String(take!(b))

g = Molecule(molstring=s)


@set basis sto-3g
@energy rhf