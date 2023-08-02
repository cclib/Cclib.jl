module Cclib
using PythonCall
using CondaPkg
using AtomsBase
using Unitful
using UnitfulAtomic
using Logging

include("config.jl")
include("functions.jl")
include("ab_integration.jl")

const cclib = Ref{Py}()

function __init__()
    cclib[] = pyimport("cclib")
end

end
