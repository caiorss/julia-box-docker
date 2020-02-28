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


macro symbolchar_table()
     symbols = [
	      ("÷", "\\div - Division")
	      ("→", "Arrow right")
	      ("∑", "\\sum  - Summation operator")
	      ("√", "\\sqrt - Square root operator")
	      ("∇", "\\nabla - gradient operator")
	      ("∂", "\\partial - Partial derivate")
   	      ("ℒ", "Laplace transform")
              ("∃", "\\exists")
              ("∀", "\\forall")
	      ("∞", "Infinite")
	      ("⍝", "APL - Comment")
	      ("⍋", "APL Symbol")
	      ("⍒", "APL Symbol")
	      ("⌾", "APL Circle jot")
	      ("⍟", "APL Circle star")
	      ("- ", "-")
              ("ℓ", "\\ell")
	      ("ϵ", "\\epsilon")
	      ("π", "\\pi")
	      ("Π", "\\Pi")
	      ("λ", "\\lambda")
	      ("Λ", "\\Lambda")
	      ("δ", "\\delta")
              ("Δ", "\\Delta")
              ("α", "\\alpha")
	      ("γ", "\\gama" )
	      ("Γ", "\\Gama" )
	      ("ζ", "\\zeta")
	      ("ω", "\\omega")
	      ("Ω", "\\Omega")
	      ("μ", "\\mu")
	      ("τ", "\\tau")
	      ("ρ", "\\rho")
	      ("θ", "\\theta")
	      ("ι", "\\iota")
	      ("κ", "\\kapa")
	      ("σ", "\\sigma")
              ("𝝇", "\\bivarsigma")
	      ("Σ", "\\Sigma")
              ("η", "\\eta")
              ("ν", "\\nu")
              ("ξ", "\\xi")
              ("ð", "\\eth")
              ("ℯ", "\\euler")
              ("ʃ", "\\esh - Integral")
           ]
   println(" See: https://docs.julialang.org/en/v1/manual/unicode-input/")
   for (sym, command) in symbols
      println("\t$sym\t$command")
   end
end


#=========== Initialization =======================#

# See: https://github.com/KristofferC/OhMyREPL.jl
@eval using OhMyREPL

# Use: the command @enter function(arg0, arg1, ... argnN-1) for debugging.
@eval using Debugger

# Change default precision for 5 digits
@format_5f

println(" [*]=>> Startup file initialized Ok. =>> ~/julia/.config/startup.jl'")

