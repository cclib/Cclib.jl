#
# General functions for parsing chemical outputs
#
export ccread
export writeXYZ

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
    writeXYZ(mol::Dict)

    Write an XYZ file to a string using atom numbers
    and atom geometries that were loaded into a Dict
    returned by `ccread` function

# Arguments
- `mol::Dict`: Dictionary that was returned by `ccread` function
- `geomIdx::Union{Int64, Nothing}`: Geometry set index. This is in place \
   for cases when there is more than geometry available. Be default, it will \
   it take the last read geometry.

# Returns
An .xyz string containing atom numbers and geometries
"""
function writeXYZ(mol::Dict, geomIdx::Union{Int64, Nothing}=nothing)
    temp = IOBuffer()

    if isnothing(geomIdx)
        coords = mol["atomcoords"] |>
                    x -> x[size(x)[1], :, :]
    else
        coords = mol["atomcoords"] |>
                    x -> x[geomIdx, :, :]
    end

    atoms = mol["atomnos"] |>
                x -> string.(x)
    xyzfile = hcat(atoms, coords)
    writedlm(temp, xyzfile)
    return String(take!(temp))
end

"""
    writeXYZ(file::String)

    Write an XYZ file to a string using atom numbers
    and atom geometries read from a Cclib-supported file format

# Arguments
- `file::String`: Cclib-supported file format
- `geomIdx::Union{Int64, Nothing}`: Geometry set index. This is in place \
   for cases when there is more than geometry available. Be default, it will \
   it take the last read geometry.

# Returns
An .xyz string containing atom numbers and geometries
"""
function writeXYZ(file::String, geomIdx::Union{Int64, Nothing}=nothing)
    return writeXYZ(ccread(file), geomIdx)
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
function ccread(file::String)
    try
        if !isfile(file)
            @error "$(file) is not file"
            return nothing
        end
        data = get_data(file)
        return data
    catch e
        if isa(e, PythonCall.PyException)
            throw(ArgumentError("Unsupported file format"))
        else
            throw(ArgumentError("Something went wrong"))
        end
    end
end
