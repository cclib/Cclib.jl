# Basically an exact application of
# <https://github.com/JuliaPy/PyCall.jl#using-pycall-from-julia-modules>.
#
# The initialization strategy is similar to the one employed by SymPy.jl, see
# <https://github.com/JuliaPy/SymPy.jl/blob/aea9fb5568022bbd68fe4b69d670ce2a22413a7c/src/SymPy.jl#L124>.

__precompile__()

module Cclib

export __version__, parser, progress, method, bridge, io, test, ccopen, ccwrite

using PyCall

"""
    cclib

Variable from `pyimport("cclib")`.
Numerous methods are available through Python's dot-call syntax.
"""
const cclib = PyCall.PyNULL()

"""
    parser

Parsers for all supported programs.
"""
const parser = PyCall.PyNULL()

"""
    progress

Ways of iIndicating progress.
"""
const progress = PyCall.PyNULL()

"""
    method

Analyses and calculations based on data parsed by cclib.
"""
const method = PyCall.PyNULL()

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
    test

Available writers for standard chemical representations.
"""
const test = PyCall.PyNULL()

function __init__()
    copy!(cclib, PyCall.pyimport_conda("cclib", "cclib"))

    """
    Version of the underlying cclib Python package.
    """
    global __version__ = cclib.__version__

    copy!(parser, PyCall.pyimport_conda("cclib.parser", "cclib"))
    copy!(progress, PyCall.pyimport_conda("cclib.progress", "cclib"))
    copy!(method, PyCall.pyimport_conda("cclib.method", "cclib"))
    copy!(bridge, PyCall.pyimport_conda("cclib.bridge", "cclib"))
    copy!(io, PyCall.pyimport_conda("cclib.io", "cclib"))

    try
        copy!(test, PyCall.pyimport_conda("cclib.test", "cclib"))
    catch err
        if !(isa(err, PyCall.PyError) && pyisinstance(err.val, PyCall.@pyglobalobjptr(:PyExc_ImportError)))
            rethrow()
        end
    end

    """
    Guess the identity of a particular log file and return an instance of it
    """
    global ccopen = io.ccopen

    """
    Write the parsed data from an outputfile to a standard chemical representation.
    """
    global ccwrite = io.ccwrite
end

end
