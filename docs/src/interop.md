# Interoperability With Other Tools

## AtomsBase.jl

Cclib.jl provides interoperability with [AtomsBase.jl](https://github.com/JuliaMolSim/AtomsBase.jl) by allowing to create AtomsBase systems.

The documentaiton below provides some essential functionality, such as creating and editing AtomsBase.jl systems.

For a detailed overview, or if you want to know how AtomsBase.jl operates behind the scenes, refer to its official documentation.

### Creating AtomsBase Systems
We can load information contained in a Cclib.jl-supported file into a system by using the following functions:
- `make_flexible_system` - for creating an AtomsBase `FlexibleSystem`

```Julia
# Input file can be found in the in the repo under "test" folder
julia> using Cclib
julia> using Unitful
julia> using AtomsBase
julia> box = [[3.0, 0.0, 0.0], [0.0, 3.0, 0.0], [0.0, 0.0, 3.0]]u"Å"
julia> boundary_conditions = [Periodic(), Periodic(), Periodic()]
julia> system = make_flexible_system("./water_mp2.out", box, boundary_conditions)

FlexibleSystem(H₂O, periodic = TTT):
    bounding_box      : [       3        0        0;
                                0        3        0;
                                0        0        3]u"Å"

    Atom(O,  [       0,        0, -0.0666785]u"Å")
    Atom(H,  [       0, -0.790649, 0.529118]u"Å")
    Atom(H,  [       0, 0.790649, 0.529118]u"Å")

      .------.
     /|      |
    O |      |
    | |      |
    |H.------.
    |H      /
    *------*

```

- `make_isolated_system` - for creating an AtomsBase `isolated_system`

```Julia
julia> using Cclib
julia> system = make_isolated_system("./water_mp2.out")

FlexibleSystem(H₂O, infinite):
    Atom(O,  [       0,        0, -0.0666785]u"Å")
    Atom(H,  [       0, -0.790649, 0.529118]u"Å")
    Atom(H,  [       0, 0.790649, 0.529118]u"Å")
```

- `get_atom_objects` - for getting an array of AtomsBase `Atom` objects in case you need more control.

```Julia
julia> using Cclib
julia> using AtomsBase
julia> mol = ccread("./water_mp2.out")
julia> atoms = get_atom_objects(mol)
julia> atoms[1]

Atom(O, atomic_number = 8, atomic_mass = 15.999 u):
    position          : [0,0,-0.066678532]u"Å"
```
### Accessing System Properties
In case we need to look at what our system contains, we can use regular `keys` to see available system-level properties and `atomkeys` to see available atom-level properties

```Julia
julia> using Cclib
julia> using AtomsBase
julia> system = make_isolated_system("./water_mp2.out")

julia> keys(system)
(:bounding_box, :boundary_conditions)

julia> atomkeys(system)
(:position, :velocity, :atomic_symbol, :atomic_number, :atomic_mass)

julia> bounding_box(system)
 [Inf a₀, 0.0 a₀, 0.0 a₀]
 [0.0 a₀, Inf a₀, 0.0 a₀]
 [0.0 a₀, 0.0 a₀, Inf a₀

 julia> atomic_symbol(system)
 3-element Vector{Symbol}:
 :O
 :H
 :H
```

### Updating and/or adding system properties
We can also update and/or add system properties by using `update_system` function that accepts keywords arguments. Below is an example of adding data that was parsed using `ccread` to a system.
```Julia
julia> using Cclib
julia> mol = ccread("./water_mp2.out")
julia> system = make_isolated_system(mol);
julia> system = update_system(system; nbasis=mol["nbasis"])
julia> system[:nbasis]
7
```

### AtomsBase.jl-supported libraries

We can use data loaded with Cclib.jl to perform calculations using other libraries that use AtomsBase.jl, such as [InteratomicPotentials.jl](https://github.com/cesmix-mit/InteratomicPotentials.jl) or [DFTK.jl](https://github.com/JuliaMolSim/DFTK.jl).

Let's first load some dependencies and make a system
```Julia
julia> using Cclib
julia> using AtomsBase
julia> using Unitful
julia> using UnitfulAtomic
julia> using InteratomicPotentials
julia> using DFTK

julia> box = [[3.0, 0.0, 0.0], [0.0, 3.0, 0.0], [0.0, 0.0, 3.0]]u"Å"
julia> boundary_conditions = [Periodic(), Periodic(), Periodic()]
julia> system = make_flexible_system("./water_mp2.out", box, boundary_conditions);
```

We can now perform calculate various properties of the system:
- using `InteratomicPotentials.jl`
```Julia
julia> ϵ = 1.0 * 1u"eV"
julia> σ = 0.25 * 1u"Å"
julia> rcutoff  = 2.25 * 1u"Å"
julia> lj = LennardJones(ϵ, σ, rcutoff, [:N, :C, :O, :H])
julia> potential_energy(system, lj)
-8.061904291397444e-5 Eₕ
```

- using `DFTK.jl`
```Julia
model  = model_LDA(system; temperature=1e-3)
basis  = PlaneWaveBasis(model; Ecut=15, kgrid=(3, 3, 3))
self_consistent_field(basis);
n     Energy            log10(ΔE)   log10(Δρ)   Diag   Δtime
---   ---------------   ---------   ---------   ----   ------
  1   -38.18166038243                    0.81    5.2
  2   -45.38103756530        0.86        0.12    3.0    253ms
  3   -45.54220597356       -0.79       -0.74    3.0    273ms
  4   -45.55809718591       -1.80       -1.40    2.1    172ms
  5   -45.55889514812       -3.10       -2.14    1.0    159ms
  6   -45.55892123307       -4.58       -2.63    1.4    158ms
  7   -45.55892315420       -5.72       -3.26    1.8    211ms
  8   -45.55892314370   +   -7.98       -3.57    1.2    113ms
  9   -45.55892319258       -7.31       -3.92    2.0    189ms
 10   -45.55892320440       -7.93       -4.94    1.1    142ms
 11   -45.55892320464       -9.63       -4.96    2.0    185ms
 12   -45.55892320468      -10.33       -5.44    1.0    134ms
 13   -45.55892320469      -11.36       -6.15    2.0    158ms
```

For a full list of tools that support AtomsBase.jl, refer to its [official
documentation](https://github.com/JuliaMolSim/AtomsBase.jl).

## Fermi.jl

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