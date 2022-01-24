# Basically an exact application of
# <https://github.com/JuliaPy/PyCall.jl#using-pycall-from-julia-modules>.
#
# The initialization strategy is similar to the one employed by SymPy.jl, see
# <https://github.com/JuliaPy/SymPy.jl/blob/aea9fb5568022bbd68fe4b69d670ce2a22413a7c/src/SymPy.jl#L124>.

__precompile__()

module Cclib

export cclib

using PyCall

"""
    cclib

Variable from `pyimport("cclib")`.
Numerous methods are available through Python's dot-call syntax.
"""
const cclib = PyCall.PyNULL()

function __init__()
    copy!(cclib, PyCall.pyimport_conda("cclib", "cclib"))
end

end
