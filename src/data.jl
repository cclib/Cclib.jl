cclibtypes = Dict(
    "aonames" => Array{String},
    "aooverlaps" => Array{Float64, 2},
    "atombasis" => Array{Array{Int64}},
    "atomcharges" => Dict{String, Array{Float64}},
    "atomcoords" => Array{Float64, 3},
    "atommasses" => Array{Float64},
    "atomnos" => Array{Int64},
    "atomspins" => Dict{Array},
    "ccenergies" => Array{Float64, 2},
    "charge" => Int64,
    "coreelectrons" => Array{}, # specify subytpe?
    "dispersionenergies" => Array{Float64},
    "enthalpy" => Float64,
    "entropy" => Float64,
    "etenergies" => Array{Float64},

    # # subtypes for these?
    "etoscs" => Array{},
    "etdips" => Array{},
    "etveldips" => Array{},
    "etmagdips" => Array{},
    "etrotats" => Array{},

    "etsecs" => Array{Array},
    "etsyms" => Array{String},
    "freeenergy" => Float64,
    "fonames" => Array{String},
    "fooverlaps" => Array{}, # subtype ?
    "fragnames" => Array{String},
    "frags" => Array{Array},
    "gbasis" => Any, # PyQuante format
    "geotargets" => Array{},
    "geovalues" => Array{},
    "grads" => Array{},
    "hessian" => Array{},
    "homos" => Array{},
    "metadata" => Dict{Any, Any},
    "mocoeffs" => Array{Array{Float64}},
    "moenergies" => Array{Array{Float64}},
    "moments" => Array{Array},
    "mosyms" => Array{Array},
    "mpenergies" => Array{Array{Float64}},
    "mult" => Int64,
    "natom" => Int64,
    "nbasis" => Int64,
    "nmo" => Int64,
    "nmrtensors" => Any, # Find the right one for this one
    "nocoeffs" => Array{Array},
    "nooccnos" => Array{Array},
    "optdone" => Bool,
    "optstatus" => Array{},
    "polarizabilities" => Array{Array{Float64, 2}},
    "pressure" => Float64,
    "scancoords" => Array{},
    "scanenergies" => Array{},
    "scannames" => Array{String},
    "scanparm" => Array{Tuple},
    "scfenergies" => Array{Float64},
    "scftargets" => Array{Float64, 2},
    "scfvalues" => Array{Array{Float64, 2}},
    "temperature" => Float64,
    "time" => Array{},
    "transprop" => Dict{Any, Any},
    "vibanharms" => Array{},
    "vibdisps" => Array{},
    "vibfreqs" => Array{},
    "vibfconsts" => Array{},
    "vibirs" => Array{},
    "vibanharms" => Array{},
    "vibrmasses" => Array{},
    "vibsyms" => Array{String},
    "zpve" => Float64
)

using Cclib
using PythonCall
m3 = ccread("./test/data/Trp_polar_tdhf.out")

for (key, value) in m3
    type = cclibtypes[key]
    m3[key] = pyconvert(type, value)
end
m3