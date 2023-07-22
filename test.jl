using AtomsBase
using Cclib
using Unitful
using UnitfulAtomic

mol = ccread("./test/data/Trp_polar_tdhf.out")
atoms = [Atom(
                mol["atomnos"][i],
                vec(mol["atomcoords"][:, i, :])u"Å"
             )
             for i in 1:mol["natom"]]

position(atoms[1])

system = isolated_system([:H => [0, 0, 1.]u"bohr", :H => [0, 0, 3.]u"bohr"]; extra_data=42)
system = isolated_system(
   atoms
)
