using Cclib
using Documenter

DocMeta.setdocmeta!(Cclib, :DocTestSetup, :(using Cclib); recursive=true)

makedocs(;
    modules=[Cclib],
    authors="Victor Hugo Cano Gil",
    repo="https://github.com/vcanogil/Cclib.jl/blob/{commit}{path}#{line}",
    sitename="Cclib.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://vcanogil.github.io/Cclib.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/vcanogil/Cclib.jl",
    devbranch="main",
)
