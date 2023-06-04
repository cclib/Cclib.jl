module Cclib

include("./functions.jl")

const cclib = Ref{Py}()

function __init__()
    cclib[] = pyimport("cclib")
end

end
