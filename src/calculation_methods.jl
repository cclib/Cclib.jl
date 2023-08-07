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

# dimensions of some outputs are NxMxK, however python return dimension N as a list, not an array
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
Tuple with 3 elements:
- `aoresults`: a three dimensional array with spin, molecular orbital, and atomic orbitals as the axes, so that ``aoresults[1][46][1]`` gives the contribution of the 1st atomic orbital to the 46th alpha/restricted molecular orbital,
- `fragresults`: a three dimensional array with spin, molecular orbital, and atoms as the axes, so that ``fragresults[1][24][5]`` gives the contribution of the 5th fragment orbitals to the 24th beta molecular orbital)
- `fragcharges`: a vector with the number of (partial) electrons in each fragment, so that ``fragcharges[3]`` gives the number of electrons in the 3rd fragment.
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
Tuple with 3 elements:
- `aoresults`: a three dimensional array with spin, molecular orbital, and atomic orbitals as the axes, so that ``aoresults[1][46][1]`` gives the contribution of the 1st atomic orbital to the 46th alpha/restricted molecular orbital,
- `fragresults`: a three dimensional array with spin, molecular orbital, and atoms as the axes, so that ``fragresults[1][24][5]`` gives the contribution of the 5th fragment orbitals to the 24th beta molecular orbital)
- `fragcharges`: a vector with the number of (partial) electrons in each fragment, so that ``fragcharges[3]`` gives the number of electrons in the 3rd fragment.
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
    lpa(file::String)

Lowdin Population Analysis
# Arguments
- `file::String`: Cclib-supported output file
# Returns
Tuple with 3 elements:
- `aoresults`: a three dimensional array with spin, molecular orbital, and atomic orbitals as the axes, so that ``aoresults[1][46][1]`` gives the contribution of the 1st atomic orbital to the 46th alpha/restricted molecular orbital,
- `fragresults`: a three dimensional array with spin, molecular orbital, and atoms as the axes, so that ``fragresults[1][24][5]`` gives the contribution of the 5th fragment orbitals to the 24th beta molecular orbital)
- `fragcharges`: a vector with the number of (partial) electrons in each fragment, so that ``fragcharges[3]`` gives the number of electrons in the 3rd fragment.
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
Tuple with 3 elements:
- `aoresults`: a three dimensional array with spin, molecular orbital, and atomic orbitals as the axes, so that ``aoresults[1][46][1]`` gives the contribution of the 1st atomic orbital to the 46th alpha/restricted molecular orbital,
- `fragresults`: a three dimensional array with spin, molecular orbital, and atoms as the axes, so that ``fragresults[1][24][5]`` gives the contribution of the 5th fragment orbitals to the 24th beta molecular orbital)
- `fragcharges`: a vector with the number of (partial) electrons in each fragment, so that ``fragcharges[3]`` gives the number of electrons in the 3rd fragment.
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

"""
    density(file::String)

Density matrix calculation
# Arguments
- `file::String`: Cclib-supported output file
# Returns
- An array with three axes. The first axis is for the spin contributions,
the second and the third axes for the density matrix, which follows standard definition.
"""
function density(file::String)
    data = cclib[].io.ccread(file)
    mol = cclib[].method.Density(data)
    mol.calculate()
    return pyconvert(Array{Float64}, mol.__dict__["density"])
end

"""
    mbo(file::String)

Calculate Mayer's bond orders
# Arguments
- `file::String`: Cclib-supported output file
# Returns
- An array with three axes. The first axis is for contributions of each spin to the MBO,
while the second and third correspond to the indices of the atoms.
"""
function mbo(file::String)
    data = cclib[].io.ccread(file)
    mol = cclib[].method.MBO(data)
    mol.calculate()
    return pyconvert(Array{Float64}, mol.__dict__["fragresults"])
end

"""
    cda(file::String)

Charge decomposition analysis
# Arguments
- `mol::String`: Cclib-supported output file
- `frag1::String`: Cclib-supported output file
- `frag2::String`: Cclib-supported output file
# Returns
- Tuple (donations, backdonations, repulsions)
donations, bdonations (back donations), and repulsions attributes.
These attributes are simply lists of 1-dimensional arrays corresponding to the restricted or alpha/beta molecular orbitals of the entire molecule.
"""
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

# TODO: this requires PyQuante which doens't seem to work
# when trying to install it into a conda env
# """
#     bader(file::string)

# bader's qtaim charges calculation
# # arguments
# - `file::string`: cclib-supported output file
# # returns
# tuple (donations, backdonations, repulsions)
# """
# function bader(file::String, vol::Vector{Vector{Float64}})
#     data = cclib[].io.ccread(file)
#     vol = pytuple(pytuple(i) for i in vol)
#     vol = cclib[].method.volume(vol...)
#     mol = cclib[].method.bader(data, vol)
#     mol.calculate()
#     return mol
#     # aoresults = mol.__dict__["aoresults"] |> expand
#     # fragresults = mol.__dict__["fragresults"] |> expand
#     # fragcharges = pyconvert(array{float64}, mol.__dict__["fragcharges"])
#     # return aoresults, fragresults, fragcharges
# end
