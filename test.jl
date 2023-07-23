using Cclib

cclib = Cclib.cclib.x
cpsa = cclib.method.CSPA
lpa = cclib.method.LPA
bick = cclib.method.Bickelhaupt
density = cclib.method.Density
mol = cclib.io.ccread("./test/data/Trp_polar.fchk")

a = lpa(mol)
a.calculate()
a.__dict__.keys()