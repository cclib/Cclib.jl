var documenterSearchIndex = {"docs":
[{"location":"calculation/#Additional-Analyses","page":"Additional Analyses","title":"Additional Analyses","text":"","category":"section"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"Cclib also allows to further analyse calculation ouputs.","category":"page"},{"location":"calculation/#C-squared-population-analysis-(CSPA)","page":"Additional Analyses","title":"C squared population analysis (CSPA)","text":"","category":"section"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"CSPA can be used to determine and interpret the electron density of a molecule. The contribution of the a-th atomic orbital to the i-th molecular orbital can be written in terms of the molecular orbital coefficients: Phi_ai = fracc^2_aisum_k c^2_ki","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"# Example calculation files can be found in the test folder of the main branch.\njulia> using Cclib\njulia> aoresults, fragresults, fragcharges = cspa(\"./Trp_polar.fchk\")","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"aoresults: a three dimensional array with spin, molecular orbital, and atomic orbitals as the axes, so that aoresults1 46 1 gives the contribution of the 1st atomic orbital to the 46th alpha/restricted molecular orbital,\nfragresults: a three dimensional array with spin, molecular orbital, and atoms as the axes, so that fragresults1 24 5 gives the contribution of the 5th fragment orbitals to the 24th beta molecular orbital)\nfragcharges: a vector with the number of (partial) electrons in each fragment, so that fragcharges3 gives the number of electrons in the 3rd fragment.","category":"page"},{"location":"calculation/#Mulliken-population-analysis-(MPA)","page":"Additional Analyses","title":"Mulliken population analysis (MPA)","text":"","category":"section"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"MPA can be used to determine and interpret the electron density of a molecule. The contribution of the a-th atomic orbital to the i-th molecular orbital in this method is written in terms of the molecular orbital coefficients, c, and the overlap matrix, S: Phi_ai = sum_b c_ai c_bi S_ab","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"julia> using Cclib\njulia> aoresults, fragresults, fragcharges = mpa(\"./Trp_polar.fchk\")","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"aoresults: a three dimensional array with spin, molecular orbital, and atomic orbitals as the axes, so that aoresults1 46 1 gives the contribution of the 1st atomic orbital to the 46th alpha/restricted molecular orbital,\nfragresults: a three dimensional array with spin, molecular orbital, and atoms as the axes, so that fragresults1 24 5 gives the contribution of the 5th fragment orbitals to the 24th beta molecular orbital)\nfragcharges: a vector with the number of (partial) electrons in each fragment, so that fragcharges3 gives the number of electrons in the 3rd fragment.","category":"page"},{"location":"calculation/#Löwdin-Population-Analysis","page":"Additional Analyses","title":"Löwdin Population Analysis","text":"","category":"section"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"julia> using Cclib\njulia> aoresults, fragresults, fragcharges = lpa(\"./Trp_polar.fchk\")","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"aoresults: a three dimensional array with spin, molecular orbital, and atomic orbitals as the axes, so that aoresults1 46 1 gives the contribution of the 1st atomic orbital to the 46th alpha/restricted molecular orbital,\nfragresults: a three dimensional array with spin, molecular orbital, and atoms as the axes, so that fragresults1 24 5 gives the contribution of the 5th fragment orbitals to the 24th beta molecular orbital)\nfragcharges: a vector with the number of (partial) electrons in each fragment, so that fragcharges3 gives the number of electrons in the 3rd fragment.","category":"page"},{"location":"calculation/#Bickelhaupt-Population-Analysis","page":"Additional Analyses","title":"Bickelhaupt Population Analysis","text":"","category":"section"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"The Bickelhaupt class available from cclib.method performs Bickelhaupt population analysis that has been proposed in Organometallics 1996, 15, 13, 2923–2931. doi:10.1021/om950966x","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"The contribution of the a-th atomic orbital to the i-th molecular orbital in this method is written in terms of the molecular orbital coefficients, c, and the overlap matrix, S:","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"Phi_aialpha = sum_b w_abalpha c_aialpha c_bialpha S_ab","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"where the weights w_ab that are applied on the Mulliken atomic orbital contributions are defined as following when the coefficients of the molecular orbitals are substituted into equation 11 in the original article.","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"w_abalpha = 2 fracsum_k c_akalpha^2sum_i c_aialpha^2 + sum_j c_bjalpha^2","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"In case of unrestricted calculations, alpha charges and beta charges are each determined to obtain total charge. In restricted calculations, alpha subscript can be ignored since the coefficients are equivalent for both spin orbitals.","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"The weights are introduced to replace the somewhat arbitrary partitioning of off-diagonal charges in the Mulliken population analysis, which divides the off-diagonal charges identically to both atoms. Bickelhaupt population analysis instead divides the off-diagonal elements based on the relative magnitude of diagonal elements.","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"julia> using Cclib\njulia> aoresults, fragresults, fragcharges = bpa(\"./Trp_polar.fchk\")","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"aoresults: a three dimensional array with spin, molecular orbital, and atomic orbitals as the axes, so that aoresults1 46 1 gives the contribution of the 1st atomic orbital to the 46th alpha/restricted molecular orbital,\nfragresults: a three dimensional array with spin, molecular orbital, and atoms as the axes, so that fragresults1 24 5 gives the contribution of the 5th fragment orbitals to the 24th beta molecular orbital)\nfragcharges: a vector with the number of (partial) electrons in each fragment, so that fragcharges3 gives the number of electrons in the 3rd fragment.","category":"page"},{"location":"calculation/#Density-Matrix-calculation","page":"Additional Analyses","title":"Density Matrix calculation","text":"","category":"section"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"Calculates the electron density matrix","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"julia> using Cclib\njulia> result = density(\"./Trp_polar.fchk\")","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"Returns an array with three axes. The first axis is for the spin contributions, the second and the third axes for the density matrix, which follows standard definition.","category":"page"},{"location":"calculation/#Mayer’s-Bond-Orders-(MBO)","page":"Additional Analyses","title":"Mayer’s Bond Orders (MBO)","text":"","category":"section"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"Calculates Mayer's bond orders","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"julia> using Cclib\njulia> result = mbo(\"./Trp_polar.fchk\")","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"Returns an array with three axes. The first axis is for contributions of each spin to the MBO, while the second and the third correspond to the indices of the atoms.","category":"page"},{"location":"calculation/#Charge-Decomposition-Analysis","page":"Additional Analyses","title":"Charge Decomposition Analysis","text":"","category":"section"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"The Charge Decomposition Analysis (CDA) as developed by Gernot Frenking et al. is used to study the donor-acceptor interactions of a molecule in terms of two user-specified fragments.","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"julia> using Cclib\njulia> donations, bdonations, repulsions = cda(\"BH3CO-sp.log\", \"BH3.log\", \"CO.log\")","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"Returns donations, bdonations (back donations), and repulsions attributes. These attributes are simply lists of 1-dimensional arrays corresponding to the restricted or alpha/beta molecular orbitals of the entire molecule.","category":"page"},{"location":"calculation/","page":"Additional Analyses","title":"Additional Analyses","text":"<!– # Bader’s QTAIM –>","category":"page"},{"location":"#Introduction","page":"Home","title":"Introduction","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Cclib.jl is a Julia wrapper around Cclib - an open source library written in Python for parsing and interpreting the results of computational chemistry packages.","category":"page"},{"location":"","page":"Home","title":"Home","text":"It allows to perform natively in Julia the following:","category":"page"},{"location":"","page":"Home","title":"Home","text":"Parse data from the output files generated by computational chemistry programs, such as Gaussian, GAMESS, PSI4 etc.\nProvide a consistent interface to the results of computational chemistry calculations, particularly those results that are useful for algorithms or visualization\nFacilitate the implementation of algorithms that are not specific to a particular computational chemistry package\nMaximize interoperability with other open source computational chemistry and cheminformatic software libraries","category":"page"},{"location":"#How-to-install","page":"Home","title":"How to install","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"To install Cclib.jl, start up and type the following into the REPL.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Pkg.add(\"Cclib\")","category":"page"},{"location":"atombase/#AtomsBase-Integration","page":"AtomsBase Integration","title":"AtomsBase Integration","text":"","category":"section"},{"location":"atombase/","page":"AtomsBase Integration","title":"AtomsBase Integration","text":"Cclib.jl allows loading atom information into AtomsBase.jl objects using get_atom_objects function:","category":"page"},{"location":"atombase/","page":"AtomsBase Integration","title":"AtomsBase Integration","text":"# Input file can be found in the in the repo under \"test\" folder\njulia> using Cclib\njulia> using AtomsBase\njulia> mol = ccread(\"./Trp_polar.fchk\")\njulia> atoms = get_atom_objects(mol)\njulia> atoms[1]\n\nAtom(N, atomic_number = 7, atomic_mass = 14.007 u):\n    position          : [-0.069982688,0.33219872,0.28212832]u\"Å\"","category":"page"},{"location":"atombase/","page":"AtomsBase Integration","title":"AtomsBase Integration","text":"Like before, all the stored information for each atom is still accessible:","category":"page"},{"location":"atombase/","page":"AtomsBase Integration","title":"AtomsBase Integration","text":"julia> keys(atoms[1])\n(:position, :velocity, :atomic_symbol, :atomic_number, :atomic_mass)","category":"page"},{"location":"atombase/#Interoperability-With-Other-Tools","page":"AtomsBase Integration","title":"Interoperability With Other Tools","text":"","category":"section"},{"location":"atombase/","page":"AtomsBase Integration","title":"AtomsBase Integration","text":"We can use data loaded with Cclib.jl to perform calculations using other libraries that use AtomsBase.jl, such as InteratomicPotentials.jl","category":"page"},{"location":"atombase/","page":"AtomsBase Integration","title":"AtomsBase Integration","text":"First, we load the data and define the system:","category":"page"},{"location":"atombase/","page":"AtomsBase Integration","title":"AtomsBase Integration","text":"julia> using Cclib\njulia> using AtomsBase\njulia> using Unitful\njulia> using UnitfulAtomic\njulia> using InteratomicPotentials\n\njulia> atoms = get_atom_objects(\"./Trp_polar.fchk\")\njulia> boundaryconditions = [Periodic(), Periodic(), Periodic()]\njulia> box = [[10.0, 0.0, 0.0], [0.0, 10.0, 0.0], [0.0, 0.0, 10.0]]u\"Å\"\njulia> system = FlexibleSystem(atoms, box, boundaryconditions)\n\nFlexibleSystem(C₁₁H₁₂N₂O₂, periodic = TTT):\n    bounding_box      : [      10        0        0;\n                                0       10        0;\n                                0        0       10]u\"Å\"\n\n          .------------------------.\n         /|  H                     |\n        / |                        |\n       /  |                        |\n      /   |    H  C      C  H      |\n     /    H                        |\n    *  C  C     C  C H C    H      |\n    |   H |  C    HN    H          |\n    |     |                        |\n    |     |   C  C                 |\n    |     |    C                   |\n    |     |      O                 |\n    |     .----------------------H-.\n    |    /                        /\n    |   /                        /\n    | H/O                       /\n    | /          H             /\n    |/                       N/\n    *------------------------*","category":"page"},{"location":"atombase/","page":"AtomsBase Integration","title":"AtomsBase Integration","text":"We can now perform calculate various properties of the system:","category":"page"},{"location":"atombase/","page":"AtomsBase Integration","title":"AtomsBase Integration","text":"julia> ϵ = 1.0 * 1u\"eV\"\njulia> σ = 0.25 * 1u\"Å\"\njulia> rcutoff  = 2.25 * 1u\"Å\"\njulia> lj = LennardJones(ϵ, σ, rcutoff, [:N, :C, :O, :H])\njulia> potential_energy(system, lj).\n-0.00039418327614247183 Eₕ","category":"page"},{"location":"atombase/","page":"AtomsBase Integration","title":"AtomsBase Integration","text":"Refer to InteratomicPotentials.jl documentation for more details.","category":"page"},{"location":"io/#Reading-files","page":"How to parse files","title":"Reading files","text":"","category":"section"},{"location":"io/","page":"How to parse files","title":"How to parse files","text":"This page outlines how to access information store in computational chemistry output files.","category":"page"},{"location":"io/#Supported-formats","page":"How to parse files","title":"Supported formats","text":"","category":"section"},{"location":"io/","page":"How to parse files","title":"How to parse files","text":"Properties that can be parsed and supported file formats can be found here.","category":"page"},{"location":"io/#How-to-read-files","page":"How to parse files","title":"How to read files","text":"","category":"section"},{"location":"io/","page":"How to parse files","title":"How to parse files","text":"# Input file can be found in the in the repo under \"test\" folder\njulia> using Cclib\njulia> mol = ccread(\"uracil_two.xyz\")","category":"page"},{"location":"io/","page":"How to parse files","title":"How to parse files","text":"The data is now stored in mol variable. To see what data it contains, we can use the keys function that comes with the standard library.","category":"page"},{"location":"io/","page":"How to parse files","title":"How to parse files","text":"julia> keys(mol)\nKeySet for a Dict{String, Any} with 4 entries. Keys:\n  \"atomcoords\"\n  \"natom\"\n  \"atomnos\"\n  \"metadata\"","category":"page"},{"location":"io/","page":"How to parse files","title":"How to parse files","text":"Accessing the data is identical to how one would access data in a dictionary:","category":"page"},{"location":"io/","page":"How to parse files","title":"How to parse files","text":"julia> mol[\"natom\"]\n12","category":"page"}]
}
