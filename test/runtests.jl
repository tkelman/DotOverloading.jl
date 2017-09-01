using DotOverloading

import Documenter
Documenter.makedocs(
    modules = [DotOverloading],
    format = :html,
    sitename = "DotOverloading.jl",
    root = joinpath(dirname(dirname(@__FILE__)), "docs"),
    pages = Any["Home" => "index.md"],
    strict = true,
    linkcheck = true,
    checkdocs = :exports,
    authors = "Brandon Taylor"
)
