using Cclib
using PythonCall

cclib = Cclib.cclib.x
cpsa = cclib.method.CSPA
lpa = cclib.method.LPA
bick = cclib.method.Bickelhaupt
density = cclib.method.Density
mol = cclib.io.ccread("./test/data/Trp_polar_tdhf.out")

a = cpsa(mol)
a.calculate()
aoresults = a.__dict__["aoresults"]
fragresults = a.__dict__["fragresults"]
fragcharges = a.__dict__["fragcharges"]

x = pyconvert(Array{Float64}, fragcharges)
reshape(x, (1, size(x)...))
