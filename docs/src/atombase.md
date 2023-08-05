# AtomsBase Integration

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
# Interoperability With Other Tools

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