# Numerical Methods (Julia / Pluto)

**Course:** DATA 750: Mathematical Tools for Data Science · **Stack:** Julia, Pluto.jl

Applied linear algebra and numerical methods, implemented as interactive Pluto notebooks.
Topics cover the mathematical backbone of data science: decompositions, spectral methods,
and optimization.

## Contents

Projects (`projects/`)
- `DATA-750_Project-01`, `Project-02`, `Project-03`: course projects
- `Bailey-FFT-extra_credit`: FFT extra-credit work

Homework (`homework/`)
- `DATA-750_HW01` through `HW05`

Topics across the set include SVD, PCA, FFT and spectral analysis, least-squares, and
optimization (gradient methods, nonlinear).

## Opening the notebooks

These are Pluto.jl notebooks (`.jl` with `@bind`/`PlutoUI` for interactivity), not plain
scripts:

```julia
import Pkg; Pkg.add("Pluto")
using Pluto; Pluto.run()
```
Then open a `.jl` file from the Pluto start page. They also read as annotated Julia source
directly on GitHub.
