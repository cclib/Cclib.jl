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


function cspa(file::String)
    #TODO: read in the original data using Julia's ccread
    # and then append to that the analysis output
    data = cclib[].io.ccread(file)
    mol = cclib[].method.CSPA(data)
    mol.calculate()
    return mol
end

function mpa(file::String)
end

function lpa(file::String)
end

function bpa(file::String)
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

function cda(file::String)
end

function bader(file::String)
end

function ddec6(file::String)
end

function hpa(file::String)
end