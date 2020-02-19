@eval import Pkg
@eval import Printf 

#=========== Useful Macros ========================#

""" Import package with an alias. 

 Examples 
```julia-repl 

julia> @import_as PyPlot py
PyPlot

julia> x = -5:1:5
-5:1:5

julia> py.plot(x, exp.(x)) 

```  

"""
macro import_as(mod, alias)
   eval(Meta.parse("import $mod"))
   eval(Meta.parse("$alias = $mod"))
end


macro format_3f()
      @eval Base.show(io::IO, f::Float64) = @Printf.printf io "%.3f" f
end

macro format_5f()
      @eval Base.show(io::IO, f::Float64) = @Printf.printf io "%.5f" f
end

macro format_10f()
      @eval Base.show(io::IO, f::Float64) = @Printf.printf io "%.10f" f
end

macro format_3e()
      @eval Base.show(io::IO, f::Float64) = @Printf.printf io "%.3E" f
end

macro format_5e()
      @eval Base.show(io::IO, f::Float64) = @Printf.printf io "%.5E" f
end

macro format_10e()
      @eval Base.show(io::IO, f::Float64) = @Printf.printf io "%.10E" f
end

macro format_3g()
      @eval Base.show(io::IO, f::Float64) = @Printf.printf io "%.3g" f
end

macro format_5g()
      @eval Base.show(io::IO, f::Float64) = @Printf.printf io "%.5g" f
end


#=========== Initialization =======================#

# See: https://github.com/KristofferC/OhMyREPL.jl
@eval using OhMyREPL

# Use: the command @enter function(arg0, arg1, ... argnN-1) for debugging.
@eval using Debugger

# Change default precision for 5 digits
@format_5f

println(" [*]=>> Startup file initialized Ok. =>> ~/julia/.config/startup.jl'")

