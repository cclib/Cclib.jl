using AtomsBase
using Cclib
using Unitful
using UnitfulAtomic
using InteratomicPotentials

mol = ccread("./test/data/Trp_polar.fchk")
atoms = [Atom(
                mol["atomnos"][i],
                vec(mol["atomcoords"][:, i, :])u"Å"
             )
             for i in 1:mol["natom"]]
bcs = [Periodic(), Periodic(), Periodic()]
box = [[10.0, 0.0, 0.0], [0.0, 10.0, 0.0], [0.0, 0.0, 10.0]]u"Å"
somesystem = FlexibleSystem(atoms, box, bcs)
somesystem = periodic_system(atoms, box)

ϵ = 1.0 * 1u"eV"
σ = 0.25 * 1u"Å"
rcutoff  = 2.25 * 1u"Å"
lj = LennardJones(ϵ, σ, rcutoff, [:N, :C, :O, :H])
potential_energy(somesystem, lj)
