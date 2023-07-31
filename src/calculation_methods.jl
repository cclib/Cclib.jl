#
# Calculation methods for qchem outputs
#
export cspa
export mpa
export density
export lpa
export bpa
export density
export mbo
export cda
export bader
export ddec6
export hpa

# dimensions of some outputs are NxMxK, however python return dimension N as a list
# which needs to be adjusted
function expand(x)
    N = length(x)
    x = pyconvert(Array{Float64}, x[0])
    return reshape(x, (N, size(x)...))
end

"""
    cspa(file::String)

C-Squared Population Analysis (CSPA)
# Arguments
- `file::String`: Cclib-supported output file
# Returns
tuple (aoresults, fragresults, fragcharges)
"""
function cspa(file::String)
    #TODO: implement the optional args from docs
    data = cclib[].io.ccread(file)
    mol = cclib[].method.CSPA(data)
    mol.calculate()
    aoresults = mol.__dict__["aoresults"] |> expand
    fragresults = mol.__dict__["fragresults"] |> expand
    fragcharges = pyconvert(Array{Float64}, mol.__dict__["fragcharges"])
    return aoresults, fragresults, fragcharges
end

"""
    mpa(file::String)

Mulliken Population Analysis
# Arguments
- `file::String`: Cclib-supported output file
# Returns
tuple (aoresults, fragresults, fragcharges)
"""
function mpa(file::String)
    data = cclib[].io.ccread(file)
    mol = cclib[].method.MPA(data)
    mol.calculate()
    aoresults = mol.__dict__["aoresults"] |> expand
    fragresults = mol.__dict__["fragresults"] |> expand
    fragcharges = pyconvert(Array{Float64}, mol.__dict__["fragcharges"])
    return aoresults, fragresults, fragcharges
end

"""
    mpa(file::String)

Lowdin Population Analysis
# Arguments
- `file::String`: Cclib-supported output file
# Returns
tuple (aoresults, fragresults, fragcharges)
"""
function lpa(file::String)
    data = cclib[].io.ccread(file)
    mol = cclib[].method.LPA(data)
    mol.calculate()
    aoresults = mol.__dict__["aoresults"] |> expand
    fragresults = mol.__dict__["fragresults"] |> expand
    fragcharges = pyconvert(Array{Float64}, mol.__dict__["fragcharges"])
    return aoresults, fragresults, fragcharges
end

"""
    bpa(file::String)

Bickelhaupt Population Analysis
# Arguments
- `file::String`: Cclib-supported output file
# Returns
tuple (aoresults, fragresults, fragcharges)
"""
function bpa(file::String)
    data = cclib[].io.ccread(file)
    mol = cclib[].method.Bickelhaupt(data)
    mol.calculate()
    aoresults = mol.__dict__["aoresults"] |> expand
    fragresults = mol.__dict__["fragresults"] |> expand
    fragcharges = pyconvert(Array{Float64}, mol.__dict__["fragcharges"])
    return aoresults, fragresults, fragcharges
end

function density(file::String)
    data = cclib[].io.ccread(file)
    mol = cclib[].method.Density(data)
    mol.calculate()
    return pyconvert(Array{Float64}, mol.__dict__["density"])
end

#ToDo: check output dimensions?
function mbo(file::String)
    data = cclib[].io.ccread(file)
    mol = cclib[].method.MBO(data)
    mol.calculate()
    return pyconvert(Array{Float64}, mol.__dict__["fragresults"])
end

#TODO Figure out the dimensions
function cda(mol::String, frag1::String, frag2::String)
    mol = cclib[].io.ccread(mol)
    frag1 = cclib[].io.ccread(frag1)
    frag2 = cclib[].io.ccread(frag2)
    mol = cclib[].method.CDA(mol)
    mol.calculate([frag1, frag2])
    donations = mol.__dict__["donations"] |> expand
    bdonations = mol.__dict__["bdonations"] |> expand
    repulsions = mol.__dict__["repulsions"] |> expand
    return donations, bdonations, repulsions
end

function bader(file::String)
end
