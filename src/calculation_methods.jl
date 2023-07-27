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

expand(x) = pyconvert(Array{Float64}, x[0]) |> x -> reshape(x, (1, size(x)...))

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

function cda(mol::String, frag1::String, frag2::String)
    mol = cclib[].io.ccread(mol)
    frag1 = cclib[].io.ccread(frag1)
    frag2 = cclib[].io.ccread(frag2)
    cda = cclib[].method.MBO(mol)
    cda.calculate()
    return cda
end

function bader(file::String)
end

function ddec6(file::String)
end

function hpa(file::String)
end