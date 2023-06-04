using PythonCall
using CondaPkg

export get_n_atom

function get_n_atom(file)
    data = cclib[].io.ccread(file)
    return pyconvert(Int64, data.natom)
end