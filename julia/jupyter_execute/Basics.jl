x = 1



typeof(x)

α = Int8(2)


Int8(2^7-1)

Int8(2^8) #Error message

@show UInt(1018);

w = .2

typeof(w)

x = 1
y = 2
x + y


x = 1
y = 2
@show x + y + .2


x = Int(42)
y = float(.964)
@show z = x+y

typeof(z)

+(x, y)

@show  ^(*( 3, +(1, 2) ), 5)

@show 1/2 

1//2

Within common fractions, we can perform arithmetic operations:


@show 1//2+1//3;


@show (1//2)^10;

@show 1//2 + .25;
@show 1//2 + π;

@show div(5,3);
@show   ÷(5,3);
@show     5÷3;

@show rem(5,3);
@show   %(5,3);
@show     5%3;

A = [1 2 3]

B = [1; 2; 3]

@show c = [1 π 2.3]

@show typeof(c) #It's Float64 despite the first element being an integer.

X = [1 2 3;
     3 4 5]

Array{Float64}(undef, 10)

Array{Int}(undef, 2, 3, 2, 2)

A = fill(π^2, 4, 3)

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

A^(-1)*A #in fact, it works

A + 1

size(A)

Below you can find `repeat` at play:

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

@show 5:120;
@show range(5, stop=120);

@show 5:.5:120;
@show range(5, stop=120, step=.5);

(1:5)*2

1:5+1

1:3 + [1; 2; 3]

collect(1:3)

collect(1:3) + [1; 2; 3]

using FIGlet

function random_economist()
    using sample
enddddd

Σ([1 2 3])

(1,2,3)

A 

broadcast(+, A, 1)

?broadcast

X = repeat(collect(1:100), 1000, 10000);
@show size(X)

@time X .+ 1;

using Pipe

exp.( collect( range(log(1), stop=log(42), length=73) ) )

@pipe range(log(1), stop=log(42), length=73) |> collect |> exp.(_)

exp.([1 2 3])

broadcast(exp, [1 2 3])

@time X + repeat([1], 100000, 10000);

repeat(A, 2, 1)

?+

@show broadcast(+, 1, [1 2;3 4])

@show broadcast(+, [0 1], [1 2;3 4])


# @show broadcast(+, [1 2 3], [1 2;3 4])

.//( 1, [1 2;3 4])

[1 2]+1

mean.([1 2 3])

using StatsBase

countmap([2; 2; 3; 4])

?countmap

counts([1.5 1.5 3 100])

using FreqTables

x = repeat(["a", "b", "c", "d"], outer=[100]);

x=[1; 1; 3; 4]
qwe = freqtable(x)



using ProgressLogging

@progress for i in 1:10
    sleep(0.1)
    
end



for i∈1:2
    for j∈ 15:.25:16 
        println("i=$i, j=$j")
    end
end

for i∈1:2, j∈ 15:.25:16
    println("i=$i, j=$j")
end

OLS(X,y) = inv(X'*X)*X'*y

qwe = collect(1:100)

map(x-> x%2==0 ? "Sargent" : "Lucas", qwe)

broadcast(x-> x%2==0 ? "Sargent" : "Lucas", qwe)

a = [(x,y) for x ∈ 1:2, y ∈ 1:1:3]

((100-1)/(100-1))^1/.5 # * (10 - -2)

-2 + ((100-1)/(100-1))^1/.5 * (10 - -2)

balance_sheet = [(-2 + ((i-1)/(100-1))^(1/.5) * (10 - -2)) for i∈1:100]

income_shocks = exp.( range(log(1), stop=log(2), length= 25) )

map(x -> begin
            x += 1
            2+2
            return(x)
        end,
        1:10)

states = [(κ,ε) for κ ∈ balance_sheet, ε ∈ income_shocks]


