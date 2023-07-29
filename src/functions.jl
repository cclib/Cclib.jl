#
# General functions for parsing chemical outputs
#

export ccread

function pyccread(file)
    data = cclib[].io.ccread(file)
    keys = pyconvert(Array, data.__dict__.keys())
    values = pyconvert(Array, data.__dict__.values())
    return Dict(zip(keys, values))
end

function get_data(file)
    datadict = pyccread(file)
    for (key, value) in datadict
        type = cclibtypes[key]
        datadict[key] = pyconvert(type, value)
    end
    return datadict
end

"""
    ccread(file::String)

Read in the file of supported format and store the data
it contains in a dictionary.
Properties read in are accessible as dictionary keys.

# Arguments
- `file::String`: Cclib-supported file format

# Returns
A dictionary containing stored information

# Example
```Julia
julia> mol = ccread("uracil_two.xyz")
julia> keys(mol)
KeySet for a Dict{String, Any} with 4 entries. Keys:
  "atomcoords"
  "natom"
  "atomnos"
  "metadata"
```
"""
function ccread(file)
    try
        if !isfile(file)
            @error "$(file) is not file"
            return nothing
        end
        data = get_data(file)
        return data
    catch e
        if isa(e, PythonCall.PyException)
            @error "Unsupported file format"
            return nothing
        end
    end
end
