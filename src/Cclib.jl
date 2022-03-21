# Basically an exact application of
# <https://github.com/JuliaPy/PyCall.jl#using-pycall-from-julia-modules>.
#
# The initialization strategy is similar to the one employed by SymPy.jl, see
# <https://github.com/JuliaPy/SymPy.jl/blob/aea9fb5568022bbd68fe4b69d670ce2a22413a7c/src/SymPy.jl#L124>.

__precompile__()

module Cclib

using PyCall


export bridge
export io
export method
export parser

export ccopen, ccwrite


"""
    bridge

Facilities for moving parsed data to other cheminformatic libraries.
"""
const bridge = PyCall.PyNULL()

"""
    io

Available writers for standard chemical representations.
"""
const io = PyCall.PyNULL()

"""
    method

Analyses and calculations based on data parsed by cclib.
"""
const method = PyCall.PyNULL()

"""
    parser

Parsers for all supported programs.
"""
const parser = PyCall.PyNULL()


"""
Guess the identity of a particular log file and return an instance of it.
"""
const ccopen = PyCall.PyNULL()

"""
Write the parsed data from an outputfile to a standard chemical representation.
"""
const ccwrite = PyCall.PyNULL()


function __init__()
    cclib = PyCall.pyimport_conda("cclib", "cclib")

    # Version of the underlying cclib Python package.
    global __version__ = cclib.__version__

    copy!(bridge, PyCall.pyimport_conda("cclib.bridge", "cclib"))
    copy!(io, PyCall.pyimport_conda("cclib.io", "cclib"))
    copy!(method, PyCall.pyimport_conda("cclib.method", "cclib"))
    copy!(parser, PyCall.pyimport_conda("cclib.parser", "cclib"))

    copy!(ccopen, io.ccopen)
    copy!(ccwrite, io.ccwrite)
end

end
