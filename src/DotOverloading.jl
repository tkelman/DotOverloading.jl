module DotOverloading

import MacroTools

fix_dot(any) = any
fix_dot(e::Expr) = MacroTools.@match e begin
    t_.s_ => :($get_field($t, $Val{$(Meta.quot(s))}()))
    any_ => any
end

inner_value(v::Val{s}) where s = s

export get_field
"""
    get_field(t, v)

Overload to implement dot overloading.
"""
get_field(t, v) = getfield(t, inner_value(v))

export @overload_dots
"""
    @overload_dots e

Allows for type stable dot-overloading. Walks through an expression and replaces
`a.b` with `get_field(a, Val{:b}())`. Overload [`get_field`](@ref) for new types.

```jldoctest
julia> using DotOverloading, ValuedTuples

julia> DotOverloading.get_field(v::ValuedTuple, value) = getindex(v, value);

julia> v = @VT a = 1 b = 2.5;

julia> @overload_dots v.a + v.b
3.5
```
"""
macro overload_dots(e)
    esc(MacroTools.prewalk(fix_dot, e))
end

end
