using Cclib
using Documenter

DocMeta.setdocmeta!(Cclib, :DocTestSetup, :(using Cclib); recursive=true)

makedocs(;
    modules=[Cclib],
    repo="https://github.com/cclib/Cclib.jl",
    sitename="Cclib.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://github.com/cclib/Cclib.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "How to parse files" => "io.md",
    ],
)

deploydocs(;
    repo="https://github.com/cclib/Cclib.jl",
    devbranch="main",
)
