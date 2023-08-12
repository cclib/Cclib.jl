using Cclib
using Molly

atoms = get_atom_objects("./test/data/uracil_two.xyz")
n_atoms = length(atoms)
atom_masses = [atomic_mass(i) for i in atoms]

atoms = [Atom(mass=atomic_mass(i), σ=0.3u"nm", ϵ=0.3u"kJ * mol^-1") for i in atoms]

boundary = CubicBoundary(2.0u"nm") # Periodic boundary conditions with a 2 nm cube
coords = place_atoms(n_atoms, boundary; min_dist=0.3u"nm") # Random placement without clashing

temp = 100.0u"K"
velocities = [random_velocity(i, temp) for i in atom_masses]

pairwise_inters = (LennardJones(),) # Don't forget the trailing comma!

sys = System(
    atoms=atoms,
    coords=coords,
    boundary=boundary,
    velocities=velocities,
    pairwise_inters=pairwise_inters,
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

potential_energy(sys)
kinetic_energy(sys)
total_energy(sys)

forces(sys)
accelerations(sys)

masses(sys)
temperature(sys) # 96.76667184796673 K
random_velocities(sys, 300.0u"K")

float_type(sys) # Float64
is_on_gpu(sys)  # false

# AtomsBase.jl interface
atomic_mass(sys, 5) # 10.0 u
position(sys, 10)

# Access properties
sys.atoms
sys.coords
sys.boundary
sys.velocities
sys.topology
sys.pairwise_inters
sys.neighbor_finder
sys.loggers

# For certain systems
virial(sys)
pressure(sys)

# Define a new system with certain properties changed
System(sys; coords=(sys.coords .* 0.5))

using GLMakie
visualize(sys.loggers.coords, boundary, "sim_lj.mp4")