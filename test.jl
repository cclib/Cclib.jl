using Cclib
using PythonCall

cclib = Cclib.cclib.x
cpsa = cclib.method.CSPA
lpa = cclib.method.LPA
bick = cclib.method.Bickelhaupt
density = cclib.method.Density
mol = cclib.io.ccread("./test/data/Trp_polar.fchk")

a = lpa(mol)
a.calculate()
a.__dict__.keys()
aoresults = a.__dict__["aoresults"]
fragresults = a.__dict__["fragresults"]
fragcharges = a.__dict__["fragcharges"]

x = pyconvert(Array{Float64}, fragcharges)
reshape(x, (1, size(x)...))


a = cda(
    "./test/data/calculation_methods/cda/BH3CO-sp.log",
    "./test/data/calculation_methods/cda/BH3.log",
    "./test/data/calculation_methods/cda/CO.log",
)
a.__dict__.keys()
z = a.__dict__["donations"]