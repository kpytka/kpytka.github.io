exp.( collect( range(log(1), stop=log(42), length=73) ) )

using Pipe
@pipe range(log(1), stop=log(42), length=73) |> collect |> exp.(_)

@pipe range(log(1), stop=log(42), length=73) |> 
                                     collect |> 
                                     exp.(_) |>
            map(x -> 2*(x-1)/(42-1) - 1, _ ) #standardizing to [-1, 1]

@pipe [1 42]|> 
            [log(_[1]) log(_[2])] |> 
range(_[1], stop=_[2], length=73) |> 
                          collect |> 
                            exp.(_)

@pipe [1 42]|> 
            [log(_[1]) log(_[2])] |> 
range(_[1], stop=_[2], length=73) |> 
                          collect |> 
                           exp.(_)|>
map(x -> 2*(x-minimum(_))/(maximum(_)-minimum(_)) - 1, _ )

x₁ = 1
xₙ = 42

y_aux   = exp.( collect( range(log(x₁), stop=log(xₙ), length=73) ) )
y_proc  = 2*(y_aux .- minimum(y_aux))./(maximum(y_aux).-minimum(y_aux)) .- 1

y_aux = nothing
x₁    = nothing
xₙ    = nothing

x₁ = 1
xₙ = 42

y_aux   = ( collect( range((x₁), stop=(xₙ), length=73) ) )
y_proc  = 2*(y_aux .- minimum(y_aux))./(maximum(y_aux).-minimum(y_aux)) .- 1

y_aux = nothing
x₁    = nothing
xₙ    = nothing

@pipe [1 42]|> 
            # [log(_[1]) log(_[2])] |> 
range(_[1], stop=_[2], length=73) |> 
                          collect |> 
                        #    exp.(_)|>
map(x -> 2*(x-minimum(_))/(maximum(_)-minimum(_)) - 1, _ )

equation  = Dict([
                    ("x" , collect(range(1, step=.1, length=100)) ),
                    ("a", 1),
                    ("b", 12),
                    ("c", π)
                ])

equation["y"] = @pipe equation |>  @. _["a"]*_["x"]^2 + _["b"]*_["x"] + _["c"];
