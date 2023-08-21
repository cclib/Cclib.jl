using Cclib
using Documenter

DocMeta.setdocmeta!(Cclib, :DocTestSetup, :(using Cclib); recursive=true)

makedocs(;
    modules=[Cclib],
    authors="cclib development team",
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
        "Additional analyses" => "calculation.md",
        "Interoperability with other tools" => "interop.md"
    ],
)

deploydocs(repo="https://github.com/cclib/Cclib.jl.git")
