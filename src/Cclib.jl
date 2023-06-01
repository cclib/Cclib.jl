module Cclib

using PythonCall
using CondaPkg

export get_n_atom

const cclib = Ref{Py}()

function __init__()
    cclib[] = pyimport("cclib")
end

function get_n_atom(file)
    data = cclib[].io.ccread(file)
    return pyconvert(Int64, data.natom)
end

end
