A = [1 2; 3 4] #our matrix

output = broadcast(+, A , 1)

broadcast(+, A , [1 2])

k₁    =  1;
kₙ    = 12;
n     = 1000;
d     = (kₙ-k₁)/(n-1);
ln_k  = collect( range(log(k₁), stop=log(kₙ), length=n) );

k = broadcast(exp, ln_k)

exp.(ln_k)

A .+ [1 2]

using BenchmarkTools

X = repeat(collect(1:100), 1000, 10000);
@show size(X)

@btime X .+ 1;

@btime X + repeat([1], 100000, 10000);


A = repeat(1:10000, 10000)
B = repeat(1:10000, 10000)



@time B  = B .+ 1;
@time A .+= 1;


x = 1:5;

broadcast( /, broadcast( - , broadcast(^, x, 2), 1), 3)

(x.^2 .- 1)./3

@. (x^2 - 1)/3

@. sum( (x - sum(x)/length(x))^2 )/(length(x) - 1)

@show sum.(x);
@show length.(x);

sum( (x .- sum(x)/length(x)).^2 )/(length(x) - 1)

@show map(+, A, 1);
@show broadcast(+, A, 1);
