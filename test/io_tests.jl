include("../src/Cclib.jl")
using .Cclib

data = get_n_atom("./test/io/uracil_two.xyz")
data == 12

using PythonCall
a = pyconvert(Dict, data.__dict__)
get(a, "metadata", nothing)


