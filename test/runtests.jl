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

mutable struct A
    b::String
    c::Int
end

mutable struct D
    a::A
    d::Int
end

d = D(A("b", 1), 2)
test(d) = @overload_dots d.a.c = 3
# inspect for type stability
Test.@inferred test(d)
