module DotOverloading

import MacroTools

value(s) = :($Val{$(Meta.quot(s))}())

fix_dot(any) = any
fix_dot(e::Expr) = MacroTools.@match e begin
    (t_.s_ = a_) => :($set_field!($t, $(value(s)), $a))
    t_.s_ => :($get_field($t, $(value(s))))
    any_ => any
end

inner_value(v::Val{s}) where s = s

export get_field
"""
    get_field(t, v)

Overload to implement dot overloading [`@overload_dots`](@ref).
"""
get_field(t, v) = getfield(t, inner_value(v))

"""
    set_field!(t, v, a)

Overload for dot overloading within [`@overload_dots`](@ref).
"""
set_field!(t, v, a) = setfield!(t, inner_value(v), a)


export @overload_dots
"""
    @overload_dots e

Allows for type stable dot-overloading. Walks through an expression and replaces
`a.b` with `get_field(a, Val{:b}())`. Overload [`get_field`](@ref) for new types.

```jldoctest
julia> using DotOverloading

julia> mutable struct A
            b::Int
            c::String
        end;

julia> a = A(1, "c");

julia> @overload_dots a.b = 2;

julia> a.b
2

julia> using ValuedTuples

julia> DotOverloading.get_field(v::ValuedTuple, value) = getindex(v, value);

julia> v = @VT a = 1 b = 2.5;

julia> test(v) = @overload_dots v.a + v.b;

julia> Test.@inferred test(v)
3.5
```
"""
macro overload_dots(e)
    esc(MacroTools.prewalk(fix_dot, e))
end

end
