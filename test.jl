using Cclib
using AtomsBase
using Unitful
using DFTK


box = [[2.0, 0.0, 0.0], [0.0, 2.0, 0.0], [0.0, 0.0, 2.0]]u"Å"
boundary_conditions = [Periodic(), Periodic(), Periodic()]
system = make_flexible_system("./test/data/calculation_methods/bader/water_mp2.out",
                       box,
                       boundary_conditions,
                       hello="there"
                       )

model  = model_LDA(system; temperature=1e-3)
basis  = PlaneWaveBasis(model; Ecut=15, kgrid=(3, 3, 3))
scfres = self_consistent_field(basis);
