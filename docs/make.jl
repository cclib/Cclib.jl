using Cclib
using Documenter

DocMeta.setdocmeta!(Cclib, :DocTestSetup, :(using Cclib); recursive=true)

makedocs(;
    modules=[Cclib],
    authors="Felipe S. S. Schneider <schneider.felipe@posgrad.ufsc.br> and contributors",
    repo="https://github.com/schneiderfelipe/Cclib.jl/blob/{commit}{path}#{line}",
    sitename="Cclib.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://schneiderfelipe.github.io/Cclib.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/schneiderfelipe/Cclib.jl",
    devbranch="main",
)
