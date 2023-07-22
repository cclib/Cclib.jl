#
# Functions for AtomsBase integration https://github.com/JuliaMolSim/AtomsBase.jl/tree/master
#
export get_atom_objects

function get_atom_objects(mol::Dict)
    atoms = [
             Atom(mol["atomnos"][i],
             vec(mol["atomcoords"][:, i, :])u"Å")
             for i in 1:mol["natom"]
            ]
    return atoms
end

function get_atom_objects(mol::String)
    mol = ccread(mol)
    atoms = [
             Atom(mol["atomnos"][i],
             vec(mol["atomcoords"][:, i, :])u"Å")
             for i in 1:mol["natom"]
            ]
    return atoms
end
