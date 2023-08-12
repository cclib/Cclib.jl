# Interoperability With Other Tools

# AtomsBase.jl

Cclib.jl allows loading atom information into [AtomsBase.jl](https://github.com/JuliaMolSim/AtomsBase.jl) objects using `get_atom_objects` function:

```Julia
# Input file can be found in the in the repo under "test" folder
julia> using Cclib
julia> using AtomsBase
julia> mol = ccread("./Trp_polar.fchk")
julia> atoms = get_atom_objects(mol)
julia> atoms[1]

Atom(N, atomic_number = 7, atomic_mass = 14.007 u):
    position          : [-0.069982688,0.33219872,0.28212832]u"Å"
```

Like before, all the stored information for each atom is still accessible:

```Julia
julia> keys(atoms[1])
(:position, :velocity, :atomic_symbol, :atomic_number, :atomic_mass)
```
# AtomsBase.jl-supported libraries

We can use data loaded with Cclib.jl to perform calculations using other libraries that use AtomsBase.jl, such as [InteratomicPotentials.jl](https://github.com/cesmix-mit/InteratomicPotentials.jl)

First, we load the data and define the system:
```Julia
julia> using Cclib
julia> using AtomsBase
julia> using Unitful
julia> using UnitfulAtomic
julia> using InteratomicPotentials

julia> atoms = get_atom_objects("./Trp_polar.fchk")
julia> boundaryconditions = [Periodic(), Periodic(), Periodic()]
julia> box = [[10.0, 0.0, 0.0], [0.0, 10.0, 0.0], [0.0, 0.0, 10.0]]u"Å"
julia> system = FlexibleSystem(atoms, box, boundaryconditions)

FlexibleSystem(C₁₁H₁₂N₂O₂, periodic = TTT):
    bounding_box      : [      10        0        0;
                                0       10        0;
                                0        0       10]u"Å"

          .------------------------.
         /|  H                     |
        / |                        |
       /  |                        |
      /   |    H  C      C  H      |
     /    H                        |
    *  C  C     C  C H C    H      |
    |   H |  C    HN    H          |
    |     |                        |
    |     |   C  C                 |
    |     |    C                   |
    |     |      O                 |
    |     .----------------------H-.
    |    /                        /
    |   /                        /
    | H/O                       /
    | /          H             /
    |/                       N/
    *------------------------*
```
We can now perform calculate various properties of the system:
```Julia
julia> ϵ = 1.0 * 1u"eV"
julia> σ = 0.25 * 1u"Å"
julia> rcutoff  = 2.25 * 1u"Å"
julia> lj = LennardJones(ϵ, σ, rcutoff, [:N, :C, :O, :H])
julia> potential_energy(system, lj).
-0.00039418327614247183 Eₕ
```
Refer to InteratomicPotentials.jl documentation for more details.

# Fermi.jl

We can use information loaded using Cclib and use it for [Fermi.jl](https://github.com/FermiQC/Fermi.jl) calculations, which accept atom numbers and XYZ coordinates as input. The latter is accessible using Cclib's `getXYZ` function.

Note that files may contain more than one geometry, in which case the index of the geometry can be specified by passing `geomIdx` argument to `getXYZ`. Be default, `getXYZ` will use the last read geometry.
```Julia
julia> using Cclib
julia> using Fermi # make sure to install using "add Fermi#master"
julia> xyzfile = getXYZ("./test/data/Trp_polar.fchk")
julia> mol = Molecule(molstring=xyzfile)
julia> @set basis sto-3g
julia> @energy rhf # this line should produce something similar to what is below.
================================================================================
|                                 Hartree-Fock                                 |
|                                  Module  by                                  |
|                         G.J.R Aroeira and M.M. Davis                         |
================================================================================
Collecting necessary integrals...
Done in    0.44575 s
Using GWH Guess
Molecule:

O    1.209153654800    1.766411818900   -0.017161397200
H    2.198480007500    1.797710062700    0.012116171900
H    0.919788188200    2.458018557000    0.629793883200


Charge: 0   Multiplicity: 1

Nuclear repulsion:    8.8880641737
 Number of AOs:                            7
 Number of Doubly Occupied Orbitals:       5
 Number of Virtual Spatial Orbitals:       2
 Guess Energy   -83.52857161946045

 Iter.            E[RHF]         ΔE       Dᵣₘₛ        t     DIIS     damp
--------------------------------------------------------------------------------
    1    -74.9454656296  -7.495e+01   1.011e-01     0.12    false     2.18
    2    -74.8779931590   6.747e-02   4.129e-02     0.00    false     1.47
    3    -74.7758359210   1.022e-01   3.788e-02     0.00    false     0.00
    4    -74.9409547085  -1.651e-01   7.125e-02     0.06     true     0.00
    5    -74.9649972656  -2.404e-02   4.621e-02     0.00     true     0.00
    6    -74.9650022441  -4.979e-06   7.385e-04     0.00     true     0.00
    7    -74.9650028906  -6.464e-07   2.615e-04     0.00     true     0.00
    8    -74.9650028947  -4.112e-09   1.362e-05     0.00     true     0.00
    9    -74.9650028947  -3.979e-13   1.273e-07     0.13     true     0.00
    10   -74.9650028947   0.000e+00   4.229e-08     0.00     true     0.00
    11   -74.9650028947   0.000e+00   1.605e-08     0.00     true     0.00
    12   -74.9650028947  -2.842e-14   1.155e-09     0.00     true     0.00
    13   -74.9650028947  -2.842e-14   2.004e-10     0.00     true     0.00
--------------------------------------------------------------------------------
    RHF done in  0.43s
    @Final RHF Energy         -74.965002894685 Eₕ

   • Orbitals Summary

    Orbital            Energy    Occupancy
          1    -20.2459299842       ↿⇂
          2     -1.2522309022       ↿⇂
          3     -0.6007847377       ↿⇂
          4     -0.4490335937       ↿⇂
          5     -0.3893764439       ↿⇂
          6      0.5733840180
          7      0.7039953043

   ✔  SCF Equations converged 😄
--------------------------------------------------------------------------------
 ⇒ Fermi Restricted Hartree--Fock Wave function
 ⋅ Basis:                  sto-3g
 ⋅ Energy:                 -74.96500289468506
 ⋅ Occ. Spatial Orbitals:  5
 ⋅ Vir. Spatial Orbitals:  2
Convergence: ΔE => 2.84e-14 Dᵣₘₛ => 2.00e-10
```