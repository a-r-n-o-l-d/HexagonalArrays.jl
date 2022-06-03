using HexagonalArrays
using Documenter

DocMeta.setdocmeta!(HexagonalArrays, :DocTestSetup, :(using HexagonalArrays); recursive=true)

makedocs(;
    modules=[HexagonalArrays],
    authors="Arnold",
    repo="https://github.com/a-r-n-o-l-d/HexagonalArrays.jl/blob/{commit}{path}#{line}",
    sitename="HexagonalArrays.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://a-r-n-o-l-d.github.io/HexagonalArrays.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/a-r-n-o-l-d/HexagonalArrays.jl",
    devbranch="main",
)
