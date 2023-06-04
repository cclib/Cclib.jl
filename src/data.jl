export mol

struct Mol
    aonames::Array{String}
    aooverlaps::Array{Any}
    atombasis::Array{}
    atomcharges::Dict{}
    atomcoords::Array{}
    atommasses::Array{}
    atomnos::Array{}
    atomspins::Dict{}
    ccenergies::Array{}
    charge::Int64
    coreelectrons::Array{}
    dispersionenergies::Array{}
    enthalpy::Float64
end