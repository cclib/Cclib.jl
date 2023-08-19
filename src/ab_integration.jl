#
# Functions for AtomsBase integration https://github.com/JuliaMolSim/AtomsBase.jl/tree/master
#
export get_atom_objects
export make_flexible_system

"""
    get_atom_objects(mol::Dict)

Load atom data contained in a cclib dictionary into a list
of AtomsBase atom objects.

# Arguments
- `mol::Dict`: Dictionary that was returned by `ccread` function

# Returns
A list of AtomsBase atom objects
"""
function get_atom_objects(mol::Dict)
    atoms = [
             Atom(mol["atomnos"][i],
             vec(mol["atomcoords"][:, i, :])u"Å")
             for i in 1:mol["natom"]
            ]
    return atoms
end

"""
    get_atom_objects(mol::String)

Load atom data contained in a cclib-supported file format
into a list of AtomsBase atom objects.

# Arguments
- `mol::String`: File supported by `ccread` function

# Returns
A list of AtomsBase atom objects
"""
function get_atom_objects(mol::String)
    return get_atom_objects(ccread(mol))
end

function make_flexible_system(mol::Dict, args...; kwargs...)
    atoms = get_atom_objects(mol)
    return FlexibleSystem(atoms, args...; kwargs...)
end

function make_flexible_system(mol::String, args...; kwargs...)
    return(make_flexible_system(ccread(mol), args...; kwargs...))
end

function make_isolated_system(mol::Dict; kwargs...)
    atoms = get_atom_objects(mol)
    return isolated_system(atoms; kwargs...)
end

function make_isolated_system(mol::String; kwargs...)
    return make_isolated_system(ccread(mol); kwargs...)
end