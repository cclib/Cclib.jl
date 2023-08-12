using Cclib
using Molly
using Unitful

mol = ccread("./test/data/calculation_methods/bader/water_mp2.out")
boundary = CubicBoundary(2.0u"nm")
temp = 0.1u"K"

atom_list = get_atom_objects(mol)

coords = []
for atom in atom_list
    push!(coords, [uconvert(u"nm", coord) for coord in position(atom)])
end
coords = [SVector(i) for i in coords]

atoms = [Atom(mass=atomic_mass(i), σ=0.3u"nm", ϵ=0.3u"kJ * mol^-1") for i in atom_list]
velocities = [random_velocity(i, temp) for i in 1:3]

bonds = InteractionList2Atoms(
    [1, 2],
    [2, 3],
    [HarmonicBond(k=300_000.0u"kJ * mol^-1 * nm^-2", r0=0.1u"nm") for i in 1:3]

)
specific_inter_lists = (bonds,)
pairwise_inters = (LennardJones(),)

sys = System(
    atoms=atoms,
    coords=coords,
    boundary=boundary,
    # velocities=velocities,
    pairwise_inters=pairwise_inters,
    specific_inter_lists=specific_inter_lists,
    # neighbor_finder=neighbor_finder,
    loggers=(
        temp=TemperatureLogger(10),
        coords=CoordinateLogger(10),
    ),
)

simulator = VelocityVerlet(
    dt=0.002u"ps",
    coupling=AndersenThermostat(temp, 1.0u"ps"),
)

simulate!(sys, simulator, 1_000)

using GLMakie
visualize(
    sys.loggers.coords,
    boundary,
    "sim_diatomic.mp4";
    # connections=[(i, i + (n_atoms ÷ 2)) for i in 1:(n_atoms ÷ 2)],
    connections= [(1, 2), (2, 3)]
)



