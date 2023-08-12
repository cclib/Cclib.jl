[![license](http://img.shields.io/badge/license-BSD-blue.svg?style=flat)](https://github.com/cclib/cclib/blob/master/LICENSE)
[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://cclib.github.io/Cclib.jl/dev/)
[![Latest release](https://img.shields.io/github/release/cclib/Cclib.jl.svg)](https://github.com/cclib/Cclib.jl/releases/latest)
[![Cclib Downloads](https://shields.io/endpoint?url=https://pkgs.genieframework.com/api/v1/badge/Cclib)](https://pkgs.genieframework.com?packages=Cclib)

# Cclib.jl

Extented Julia bindings to [cclib](https://github.com/cclib/cclib) library.

## Features

- Parsing outputs of quantum chemistry programs, such as such as Gaussian, GAMESS, and PSI4.

- Further analysis of calculation outputs, such as population analysis.

- Integration with [AtomsBase.jl](https://github.com/JuliaMolSim/AtomsBase.jl) - an interface for atomic geometries.
    - By extension, provides interoperability with libraries that use AtomsBase.jl, such as [Molly.jl](https://github.com/JuliaMolSim/Molly.jl) and [InteratomicPotentials.jl](https://github.com/cesmix-mit/InteratomicPotentials.jl).
- Integration with [Fermi.jl](https://github.com/FermiQC/Fermi.jl) - quantum chemistry framework written in Julia.


## Installation (Julia ≥ 1.9 Recommended)
In the Julia REPL
```julia
using Pkg; Pkg.add("Cclib")
```