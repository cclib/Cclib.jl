using Molly
using GLMakie
using Zygote
using Flux
using Format
using LinearAlgebra

dist_true = 1.0f0

model = Chain(
    Dense(1, 5, relu),
    Dense(5, 1, tanh),
)
ps = Flux.params(model)

struct NNBonds end

function Molly.forces(inter::NNBonds,
                        sys,
                        neighbors=nothing;
                        n_threads=Threads.nthreads())
    vec_ij = vector(sys.coords[1], sys.coords[3], sys.boundary)
    dist = norm(vec_ij)
    f = model([dist])[1] * normalize(vec_ij)
    fs = [f, zero(f), -f]
    return fs
end

n_steps = 400
mass = 10.0f0
boundary = CubicBoundary(5.0f0)
temp = 0.01f0
coords = [
    SVector(2.3f0, 2.07f0, 0.0f0),
    SVector(2.5f0, 2.93f0, 0.0f0),
    SVector(2.7f0, 2.07f0, 0.0f0),
]
n_atoms = length(coords)
velocities = zero(coords)
simulator = VelocityVerlet(
    dt=0.02f0,
    coupling=BerendsenThermostat(temp, 0.5f0),
)

function loss()
    atoms = [Atom(0, 0.0f0, mass, 0.0f0, 0.0f0, false) for i in 1:n_atoms]
    loggers = (coords=CoordinateLogger(Float32, 10),)
    general_inters = (NNBonds(),)

    sys = System(
        atoms=atoms,
        coords=deepcopy(coords),
        boundary=boundary,
        velocities=deepcopy(velocities),
        general_inters=general_inters,
        loggers=loggers,
        force_units=NoUnits,
        energy_units=NoUnits,
    )

    simulate!(sys, simulator, n_steps)

    dist_end = (norm(vector(sys.coords[1], sys.coords[2], boundary)) +
                norm(vector(sys.coords[2], sys.coords[3], boundary)) +
                norm(vector(sys.coords[3], sys.coords[1], boundary))) / 3
    loss_val = abs(dist_end - dist_true)

    Zygote.ignore() do
        printfmt("Dist end {:6.3f}  |  Loss {:6.3f}\n", dist_end, loss_val)
        visualize(sys.loggers.coords, boundary, "sim.mp4"; show_boundary=false)
    end

    return loss_val
end

function train()
    n_epochs = 20
    opt = ADAM(0.02, (0.9, 0.999))

    for epoch_n in 1:n_epochs
        printfmt("Epoch {:>2}  |  ", epoch_n)
        Flux.train!(loss, ps, ((),), opt)
    end
end

train()