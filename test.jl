using Cclib

cclib = Cclib.cclib.x
cpsa = cclib.method.CSPA
mol = cclib.io.ccread("./test/data/uracil_two.xyz")

a = cpsa(mol)
a.calculate()
