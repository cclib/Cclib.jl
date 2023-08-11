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
# How to write files
Cclib supports writing of .xyz files.
```Julia
julia> xyzfile = writeXYZ("Trp_polar.fchk")
julia> println(xyzfile)
7       -0.06998268758412804    0.3321987190713997      0.2821283179871149
6       1.3728035434230117      0.09707133198218713     -0.012958773909478938
6       2.0969275432768164      -0.052359305409419306   1.3682652244104354
8       3.1382490100997074      -0.6563684778600396     1.5380162935298862
6       1.9529664599995602      1.3136139875705644      -0.795602198857898
1       1.8442727359079212      2.205060503569837       -0.18016317897149903
1       1.3455899915069147      1.4594935022822686      -1.6885689510239603
6       3.4053646854450443      1.1270611821645349      -1.191807522073201
6       4.484524968733339       1.6235038030128155      -0.5598917992434116
7       5.650908965474667       1.2379326345239627      -1.2284610662545432
1       6.600931445766804       1.4112351018658895      -0.9028629375212801
6       5.29216195385127        0.435627426782999       -2.313161702646659
6       3.8942019502511815      0.35579980201064276     -2.3263315793158443
6       3.2659168805147445      -0.38326075697308876    -3.343130953018541
1       2.1864306663987114      -0.45770588432034504    -3.381591870213079
6       4.03817623649985        -1.0087512656717375     -4.287099376137604
1       3.569689058142032       -1.5824763128441464     -5.075560974130604
6       5.44451593586302        -0.9194874735270167     -4.251900291395737
1       6.0229926186734914      -1.427797353713903      -5.013000707614342
6       6.086957601971403       -0.2024044960872716     -3.2767702733596704
1       7.165665078903875       -0.1287762495461147     -3.245865064801349
1       4.54576216521982        2.2425310761977206      0.3253979653365313
1       -0.5159777860337125     0.7478905866699973      -0.5487661023893002
1       1.5420526562072914      -0.8143939695473311     -0.593546321542104
1       -0.5302278763769256     -0.5823989654647506     0.4084507632810965
8       1.4575846648306545      0.5996887301423094      2.4093500273092956
1       0.5990015353244624      0.8842421228216004      2.004783047982031
```
Note that files may contain more than one geometry, in which case the index of the geometry can be specified by passing `geomIdx` argument. Be default, writeXYZ will use the last read geometry.