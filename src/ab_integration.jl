#
# Functions for AtomsBase integration https://github.com/JuliaMolSim/AtomsBase.jl/tree/master
#
export get_atom_objects
export make_flexible_system
export make_isolated_system
export update_system

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

"""
    make_flexible_system(mol::Dict)

Create an AtomsBase FlexiblySystem.

# Arguments
- `mol::Dict`: Dictionary that was returned by `ccread` function
- `args` will typically include `bounding_box` and `boundary_conditions`
- `kwargs` passed will be stored as custom properties of the system

# Returns
An AtomsBase FlexibleSystem

# Example
```Julia
julia> box = [[3.0, 0.0, 0.0], [0.0, 3.0, 0.0], [0.0, 0.0, 3.0]]u"Å"
julia> boundary_conditions = [Periodic(), Periodic(), Periodic()]
julia> myownproperty = "hello"
julia> mol = make_flexible_system(
                                 ccread("water_mp2.out"),
                                 box,
                                 boundary_conditions
                                 myownproperty = myownproperty
                                 )
FlexibleSystem(H₂O, periodic = TTT):
bounding_box      : [       3        0        0;
    0        3        0;
    0        0        3]u"Å"
myownproperty     : hello

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
"""
function make_flexible_system(mol::Dict, args...; kwargs...)
    atoms = get_atom_objects(mol)
    return FlexibleSystem(atoms, args...; kwargs...)
end

"""
    make_flexible_system(mol::String)

Create an AtomsBase FlexiblySystem.

# Arguments
- `mol::String`: File supported by `ccread` function
- `args` will typically include `bounding_box` and `boundary_conditions`
- `kwargs` passed will be stored as custom properties of the system

# Returns
An AtomsBase FlexibleSystem

# Example
```Julia
julia> box = [[3.0, 0.0, 0.0], [0.0, 3.0, 0.0], [0.0, 0.0, 3.0]]u"Å"
julia> boundary_conditions = [Periodic(), Periodic(), Periodic()]
julia> myownproperty = "hello"
julia> mol = make_flexible_system(
                                 "water_mp2.out",
                                 box,
                                 boundary_conditions
                                 myownproperty = myownproperty
                                 )
FlexibleSystem(H₂O, periodic = TTT):
bounding_box      : [       3        0        0;
    0        3        0;
    0        0        3]u"Å"
myownproperty     : hello

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
"""
function make_flexible_system(mol::String, args...; kwargs...)
    return(make_flexible_system(ccread(mol), args...; kwargs...))
end

"""
    make_isolated_system(mol::Dict)

Create an AtomsBase isolated_system.

# Arguments
- `mol::Dict`: Dictionary that was returned by `ccread` function
- `kwargs` passed will be stored as custom properties of the system

# Returns
An AtomsBase isolated_system
"""
function make_isolated_system(mol::Dict; kwargs...)
    atoms = get_atom_objects(mol)
    return isolated_system(atoms; kwargs...)
end

"""
    make_isolated_system(mol::String)

Create an AtomsBase isolated_system.

# Arguments
- `mol::String`: File supported by `ccread` function
- `kwargs` passed will be stored as custom properties of the system

# Returns
An AtomsBase isolated_system
"""
function make_isolated_system(mol::String; kwargs...)
    return make_isolated_system(ccread(mol); kwargs...)
end

"""
    update_system(system::AbstractSystem)

Update the system by changing and/or adding new properties,
which are given as `kwargs`.
Supported `kwargs` include `particles`, `atoms`, `bounding_box`,
and `boundary_conditions`. User-specified `kwargs` are passed as
custom properties.

# Arguments
- `system::AbstractSystem`: An AtomsBase System

# Returns
An updated AtomsBase system
"""
function update_system(system; kwargs...)
    return AbstractSystem(system; kwargs...)
end
