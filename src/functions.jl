using PythonCall
using CondaPkg

export ccread


function ccread(file)
    data = cclib[].io.ccread(file)
    keys = pyconvert(Array, data.__dict__.keys())
    values = pyconvert(Array, data.__dict__.values())
    return Dict(zip(keys, values))
end