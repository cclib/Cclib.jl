[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://cclib.github.io/Cclib.jl/dev/)
[![Latest release](https://img.shields.io/github/release/cclib/Cclib.jl.svg)](https://github.com/cclib/Cclib.jl/releases/latest)
[![CI](https://github.com/cclib/Cclib.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/cclib/Cclib.jl/actions/workflows/CI.yml)
[![Cclib Downloads](https://shields.io/endpoint?url=https://pkgs.genieframework.com/api/v1/badge/Cclib)](https://pkgs.genieframework.com?packages=Cclib)
[![license](http://img.shields.io/badge/license-BSD-blue.svg?style=flat)](https://github.com/cclib/cclib/blob/master/LICENSE)

# Cclib.jl

Extented Julia bindings to [cclib](https://github.com/cclib/cclib) library.

## Quickstart
```Julia
# Input files can be found in the in the repo under "test" folder
julia> using Pkg
julia> Pkg.add("Cclib")
julia> using Cclib
julia> mol = ccread("uracil_two.xyz")
julia> keys(mol)
KeySet for a Dict{String, Any} with 4 entries. Keys:
  "atomcoords"
  "natom"
  "atomnos"
  "metadata"
julia> mol["natom"]
12
```

## Features

- Parsing outputs from 16 different programs: ADF, DALTON, Firefly, GAMESS (US), GAMESS-UK, Gaussian, Jaguar, Molpro, MOLCAS, MOPAC, NWChem, ORCA, Psi4, NBO, QChem and Turbomole.

- Further analysis of calculation outputs, such as population analysis.

- Integration with [AtomsBase.jl](https://github.com/JuliaMolSim/AtomsBase.jl) - an interface for atomic geometries.
    - By extension, provides interoperability with libraries that use AtomsBase.jl, such as [DFTK.jl](https://github.com/JuliaMolSim/DFTK.jl), [Molly.jl](https://github.com/JuliaMolSim/Molly.jl), and [InteratomicPotentials.jl](https://github.com/cesmix-mit/InteratomicPotentials.jl).
- Integration with [Fermi.jl](https://github.com/FermiQC/Fermi.jl) - quantum chemistry framework written in Julia.


## Installation (Julia ≥ 1.9 Recommended)
In the Julia REPL
```julia
using Pkg; Pkg.add("Cclib")
```