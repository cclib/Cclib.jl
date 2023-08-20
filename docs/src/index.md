# Introduction

[Cclib.jl](https://github.com/cclib/Cclib.jl) is a Julia wrapper around [Cclib](https://cclib.github.io/index.html) - an open source library written in Python for parsing and interpreting the results of computational chemistry packages.

# Features

- Parsing outputs from 15 different programs: ADF, DALTON, Firefly, GAMESS (US), GAMESS-UK, Gaussian, Jaguar, Molpro, MOLCAS, MOPAC, NWChem, ORCA, Psi4, NBO, QChem and Turbomole.

- Further analysis of calculation outputs, such as population analysis.

- Integration with [AtomsBase.jl](https://github.com/JuliaMolSim/AtomsBase.jl) - an interface for atomic geometries.
    - By extension, provides interoperability with libraries that use AtomsBase.jl, such as [DFTK.jl](https://github.com/JuliaMolSim/DFTK.jl), [Molly.jl](https://github.com/JuliaMolSim/Molly.jl) and [InteratomicPotentials.jl](https://github.com/cesmix-mit/InteratomicPotentials.jl).
- Integration with [Fermi.jl](https://github.com/FermiQC/Fermi.jl) - quantum chemistry framework written in Julia.

# How to install
To install [Cclib.jl](https://github.com/cclib/Cclib.jl), start up and type the following into the REPL.
```julia
Pkg.add("Cclib")
```

