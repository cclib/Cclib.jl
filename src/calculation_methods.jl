#
# Calculation methods for qchem outputs
#
export cspa

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

function getdensitymatrix(file::String)
end

function mbo(file::String)
end

function cda(file::String)
end

function bader(file::String)
end

function ddec6(file::String)
end

function hpa(file::String)
end