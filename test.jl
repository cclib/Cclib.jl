using Cclib
using AtomsBase
using Unitful

atoms = get_atom_objects("./test/data/Trp_polar.fchk")

a = make_atomsbase_system(ccread("./test/data/Trp_polar.fchk"),
                       box,
                       boundary_conditions
                       )

a = make_flexible_system("./test/data/Trp_polar.fchk",
                       box,
                       boundary_conditions,
                       )

box = [[10.0, 0.0, 0.0], [0.0, 10.0, 0.0], [0.0, 0.0, 10.0]]u"Å"
boundary_conditions = [Periodic(), Periodic(), Periodic()]
system = isolated_system(atoms)