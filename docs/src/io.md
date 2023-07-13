# How to read files

This page outlines how to access information store in computational chemistry output files.

### Reading files
```Julia
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