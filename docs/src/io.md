# Reading and writing files

# Supported formats
Properties that can be parsed and supported file formats can be found [here](https://cclib.github.io/data.html#details-of-current-implementation").

# How to read files
```Julia
# Input files can be found in the in the repo under "test" folder
julia> using Cclib
julia> mol = ccread("uracil_two.xyz")
```
The data is now stored in ```mol``` variable. To see what data it contains, we can use the ```keys``` function that comes with the standard library.
```Julia
julia> keys(mol)
KeySet for a Dict{String, Any} with 4 entries. Keys:
  "atomcoords"
  "natom"
  "atomnos"
  "metadata"
```
Accessing the data is identical to how one would access data in a dictionary:
```Julia
julia> mol["natom"]
12
```