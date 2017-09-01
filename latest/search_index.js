var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#DotOverloading.get_field-Tuple{Any,Any}",
    "page": "Home",
    "title": "DotOverloading.get_field",
    "category": "Method",
    "text": "get_field(t, v)\n\nOverload to implement dot overloading @overload_dots.\n\n\n\n"
},

{
    "location": "index.html#DotOverloading.@overload_dots-Tuple{Any}",
    "page": "Home",
    "title": "DotOverloading.@overload_dots",
    "category": "Macro",
    "text": "@overload_dots e\n\nAllows for type stable dot-overloading. Walks through an expression and replaces a.b with get_field(a, Val{:b}()). Overload get_field for new types.\n\njulia> using DotOverloading\n\njulia> mutable struct A\n            b::Int\n            c::String\n        end;\n\njulia> a = A(1, \"c\");\n\njulia> @overload_dots a.b = 2;\n\njulia> a.b\n2\n\njulia> using ValuedTuples\n\njulia> DotOverloading.get_field(v::ValuedTuple, value) = getindex(v, value);\n\njulia> v = @VT a = 1 b = 2.5;\n\njulia> test(v) = @overload_dots v.a + v.b;\n\njulia> Test.@inferred test(v)\n3.5\n\n\n\n"
},

{
    "location": "index.html#DotOverloading.set_field!-Tuple{Any,Any,Any}",
    "page": "Home",
    "title": "DotOverloading.set_field!",
    "category": "Method",
    "text": "set_field!(t, v, a)\n\nOverload for dot overloading within @overload_dots.\n\n\n\n"
},

{
    "location": "index.html#DotOverloading.jl-1",
    "page": "Home",
    "title": "DotOverloading.jl",
    "category": "section",
    "text": "Modules = [DotOverloading]"
},

]}
