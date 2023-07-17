module Cclib
using PythonCall
using CondaPkg
using Logging

include("functions.jl")
include("config.jl")

const cclib = Ref{Py}()

function __init__()
    cclib[] = pyimport("cclib")
end

end
