# Additional Analyses

Cclib also allows to further analyse calculation ouputs.

# C squared population analysis (CSPA)
**CSPA** can be used to determine and interpret the electron density of a molecule. The contribution of the a-th atomic orbital to the i-th molecular orbital can be written in terms of the molecular orbital coefficients:

$$\Phi_{ai} = \frac{c^2_{ai}}{\sum_k c^2_{ki}}$$

```Julia
# Example calculation files can be found in the test folder of the main branch.
julia> using Cclib
julia> aoresults, fragresults, fragcharges = cspa("./Trp_polar.fchk")
```

* ``aoresults``: a three dimensional array with spin, molecular orbital, and atomic orbitals as the axes, so that ``aoresults[1, 46, 1]`` gives the contribution of the 1st atomic orbital to the 46th alpha/restricted molecular orbital,
* ``fragresults``: a three dimensional array with spin, molecular orbital, and atoms as the axes, so that ``fragresults[1, 24, 5]`` gives the contribution of the 5th fragment orbitals to the 24th beta molecular orbital)
* ``fragcharges``: a vector with the number of (partial) electrons in each fragment, so that ``fragcharges[3]`` gives the number of electrons in the 3rd fragment.

# Mulliken population analysis (MPA)
MPA can be used to determine and interpret the electron density of a molecule. The contribution of the a-th atomic orbital to the i-th molecular orbital in this method is written in terms of the molecular orbital coefficients, c, and the overlap matrix, S:

$$\Phi_{ai} = \sum_b c_{ai} c_{bi} S_{ab}$$

```Julia
julia> using Cclib
julia> aoresults, fragresults, fragcharges = mpa("./Trp_polar.fchk")
```

* ``aoresults``: a three dimensional array with spin, molecular orbital, and atomic orbitals as the axes, so that ``aoresults[1, 46, 1]`` gives the contribution of the 1st atomic orbital to the 46th alpha/restricted molecular orbital,
* ``fragresults``: a three dimensional array with spin, molecular orbital, and atoms as the axes, so that ``fragresults[1, 24, 5]`` gives the contribution of the 5th fragment orbitals to the 24th beta molecular orbital)
* ``fragcharges``: a vector with the number of (partial) electrons in each fragment, so that ``fragcharges[3]`` gives the number of electrons in the 3rd fragment.

# Löwdin Population Analysis
```Julia
julia> using Cclib
julia> aoresults, fragresults, fragcharges = lpa("./Trp_polar.fchk")
```

* ``aoresults``: a three dimensional array with spin, molecular orbital, and atomic orbitals as the axes, so that ``aoresults[1, 46, 1]`` gives the contribution of the 1st atomic orbital to the 46th alpha/restricted molecular orbital,
* ``fragresults``: a three dimensional array with spin, molecular orbital, and atoms as the axes, so that ``fragresults[1, 24, 5]`` gives the contribution of the 5th fragment orbitals to the 24th beta molecular orbital)
* ``fragcharges``: a vector with the number of (partial) electrons in each fragment, so that ``fragcharges[3]`` gives the number of electrons in the 3rd fragment.

# Bickelhaupt Population Analysis
The Bickelhaupt class available from cclib.method performs Bickelhaupt population analysis that has been proposed in *Organometallics* 1996, 15, 13, 2923–2931. [doi:10.1021/om950966x](https://pubs.acs.org/doi/abs/10.1021/om950966x)

The contribution of the a-th atomic orbital to the i-th molecular orbital in this method is written in terms of the molecular orbital coefficients, c, and the overlap matrix, S:

$$\Phi_{ai,\alpha} = \sum_b w_{ab,\alpha} c_{ai,\alpha} c_{bi,\alpha} S_{ab}$$

where the weights $w_{ab}$ that are applied on the Mulliken atomic orbital contributions are defined as following when the coefficients of the molecular orbitals are substituted into equation 11 in the original article.

$$w_{ab,\alpha} = 2 \frac{\sum_k c_{ak,\alpha}^2}{\sum_i c_{ai,\alpha}^2 + \sum_j c_{bj,\alpha}^2}$$

In case of unrestricted calculations, $\alpha$ charges and $\beta$ charges are each determined to obtain total charge. In restricted calculations, $\alpha$ subscript can be ignored since the coefficients are equivalent for both spin orbitals.

The weights are introduced to replace the somewhat arbitrary partitioning of off-diagonal charges in the Mulliken population analysis, which divides the off-diagonal charges identically to both atoms. Bickelhaupt population analysis instead divides the off-diagonal elements based on the relative magnitude of diagonal elements.
```Julia
julia> using Cclib
julia> aoresults, fragresults, fragcharges = bpa("./Trp_polar.fchk")
```
* ``aoresults``: a three dimensional array with spin, molecular orbital, and atomic orbitals as the axes, so that ``aoresults[1, 46, 1]`` gives the contribution of the 1st atomic orbital to the 46th alpha/restricted molecular orbital,
* ``fragresults``: a three dimensional array with spin, molecular orbital, and atoms as the axes, so that ``fragresults[1, 24, 5]`` gives the contribution of the 5th fragment orbitals to the 24th beta molecular orbital)
* ``fragcharges``: a vector with the number of (partial) electrons in each fragment, so that ``fragcharges[3]`` gives the number of electrons in the 3rd fragment.

# Density Matrix calculation
Calculates the electron density matrix
```Julia
julia> using Cclib
julia> result = density("./Trp_polar.fchk")
```
Returns an array with three axes. The first axis is for the spin contributions, the second and the third axes for the density matrix, which follows standard definition.
# Mayer’s Bond Orders (MBO)
Calculates Mayer's bond orders
```Julia
julia> using Cclib
julia> result = mbo("./Trp_polar.fchk")
```
Returns an array with three axes. The first axis is for contributions of each spin to the MBO, while the second and the third correspond to the indices of the atoms.
# Charge Decomposition Analysis
The Charge Decomposition Analysis (CDA) as developed by Gernot Frenking et al. is used to study the donor-acceptor interactions of a molecule in terms of two user-specified fragments.
```Julia
julia> using Cclib
julia> donations, bdonations, repulsions = cda("BH3CO-sp.log", "BH3.log", "CO.log")
```
Returns donations, bdonations (back donations), and repulsions attributes.
These attributes are simply lists of 1-dimensional arrays corresponding to the restricted or alpha/beta molecular orbitals of the entire molecule.

<!-- # Bader’s QTAIM -->
