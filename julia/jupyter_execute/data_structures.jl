A = [1 2 3]

B = [1; 2; 3]

@show c = [1 π 2.3]

@show typeof(c) #It's Float64 despite the first element being an integer.

X = [1 2 3;
     3 4 5]

Array{Float64}(undef, 10)

Array{Int}(undef, 2, 3, 2, 2)

A = fill(π^2, 4, 3)

B = similar(A)

zeros(3,2)

using LinearAlgebra
I(5)

A = [1 2 3 4 5;
     6 7 5 9 12]

size(A)

A[1,:] #1st row

A[:,1] #1st column

A[:,[1,3]] #1st and 3rd column

A[:,3:end] #from 3rd to the last columns

A[1,3:end] #1st row and from 3rd to the last columns

A = [1 2;3 4];
B = I(2);

A + B

A*A

A

A' #transposition

A^(-1) #invert matrix

maximum(A) #notice that `max`` works in a bit different way than in Matlab!

A^(-1)*A 

kron(A,I(3))

A + 1

size(A)

repeat([1], 3)

repeat([1], 3, 2)

repeat([1], 4, 3, 2)

repeat([1; 2], 2, 3) #input argument: column vector

repeat([1 2], 2, 3) #input argument: row vector

A + repeat([1], 2, 2)

A + repeat([0; 1], 1, 2)

@show V₀ = [1 2 3];

@show V₁ = V₀;


@show V₁[1] = 420;
@show V₁;
@show V₀;

@show V₀[3] = 128;
@show V₁;
@show V₀;

@show V₀ = [1 2 3];
@show V₁ = deepcopy(V₀);

@show V₁[1] = 420;
@show V₁;
@show V₀;

@show V₀[3] = 128;
@show V₁;
@show V₀;

@show V₀ = [1 2 3];
@show V₁ = 2*V₀;

@show V₁[1] = 420;
@show V₁;
@show V₀;

@show V₀[3] = 128;
@show V₁;
@show V₀;

my_first_dict = Dict("X" => 2,
                     "Y" => 1:10)


params = Dict([ 
                ("β" , (1/1.04)^(1/12)),
                ("b" , [.55 0]) ,
                ("vec_states" , 1:2) ,
                ("π", [1:10 20:29])
            ])


@show params["β"]
params["π"]

params["π"][1:(end-1),1]  .+= 1;
params["π"]

params["Σ"] = 12

params 

equation_copy = equation;

println("Before assignment:")
@show equation["c"];
@show equation_copy["c"];


println("ASSIGNMENT: equation_copy[\"c\"] = 420")
equation_copy["c"] = 420;

println("After assignment:")
@show equation["c"];
@show equation_copy["c"];


equation  = Dict([
                    ("x" , collect(range(1, step=.1, length=100)) ),
                    ("a", 1),
                    ("b", 12),
                    ("c", π)
                ])

equation["y"] = @. equation["a"]*equation["x"]^2 + equation["b"]*equation["x"] + equation["c"]

@show a #object a is only defined in dictionary equation, so you cannot access it

using Parameters
@unpack a, b, c, x = equation
@show a #now it works


equation["y"] = @. a*x^2 + b*x + c

@show equation["a"];
@show a;

@show a += 1;

@show equation["a"]; # `a += 1;` didn't change  the value of `equation["a"]`
@show a;             # `a += 1;`        changed the value of `a`

@show equation["x"];
@show x;


@show x .+= 1;

@show equation["x"]; # `x .+= 1;`        CHANGED the value of `equation["x"]`
@show x;             # `x .+= 1;`        changed the value of `x`

@show 5:120;
@show range(5, stop=120);

@show 5:.5:120;
@show range(5, stop=120, step=.5);

(1:5)*2

1:5+1

1:3 + [1; 2; 3]

collect(1:3)

collect(1:3) + [1; 2; 3]

(1,2,3)
