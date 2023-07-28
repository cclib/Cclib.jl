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

# remake this function such that it's not (1, size(x)) but len(x), size(x)
expand(x) = pyconvert(Array{Float64}, x[0]) |> x -> reshape(length(x), (1, size(x)...))

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

function mpa(file::String)
    data = cclib[].io.ccread(file)
    mol = cclib[].method.MPA(data)
    mol.calculate()
    aoresults = mol.__dict__["aoresults"] |> expand
    fragresults = mol.__dict__["fragresults"] |> expand
    fragcharges = pyconvert(Array{Float64}, mol.__dict__["fragcharges"])
    return aoresults, fragresults, fragcharges
end

function lpa(file::String)
    data = cclib[].io.ccread(file)
    mol = cclib[].method.LPA(data)
    mol.calculate()
    aoresults = mol.__dict__["aoresults"] |> expand
    fragresults = mol.__dict__["fragresults"] |> expand
    fragcharges = pyconvert(Array{Float64}, mol.__dict__["fragcharges"])
    return aoresults, fragresults, fragcharges
end

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
    return mol
    # donations = mol.__dict__["donations"] |> expand
    # bdonations = mol.__dict__["bdonations"] |> expand
    # repulsions = mol.__dict__["repulsions"] |> expand
    # return donations, bdonations, repulsions
end

function bader(file::String)
end
