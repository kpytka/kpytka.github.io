function add_numbers(x, y)
    output = x + y
    return output
end

@show add_numbers(5, 12)

@show w = add_numbers(10,10)

function add_first_ten_numbers()
    Σ = sum( 1:10 )
    return Σ
end

add_first_ten_numbers()

function add_and_multiply(x, y)
    out1 = x+y
    out2 = x*y

    return out1, out2
    
end


@show res1, res2 = add_and_multiply(2,3);

res1

res2



f(x,y,z) = (x^2 + y)/z
@show f(2,1,3)

g(x) = begin 
        y = x^2
        y += 1
        return(y)
    end

x -> x^2
(x,y) -> x+y

(x -> x^2)(3)

x -> begin
        x = x + 1
        x = 2*x
        return(x)
    end

x = 1:5;

map(xᵢ -> (xᵢ^2-1)/3, x)

map((x,y) -> x^y, 
                    1:4,      #array with x elements
                    [2 2 3 3] #array with y elements
                    )

σ = 12

function modify_σ()
    σ = σ + 1;
    return(σ)
end

modify_σ()

σ = 12

function modify_σ()
    global σ
    σ = σ + 1;
    return(σ)
end

modify_σ()

@show σ

equation  = Dict([
                    ("x" , collect(range(1, step=.1, length=100)) ),
                    ("a", 1),
                    ("b", 12),
                    ("c", π)
                ])

using Parameters

function multiply_coefficients(X)        
    @unpack  a, b, c  = X;

    a *= 2;
    b *= 2;
    c *= 2;
    

    output = deepcopy(X)
    
    #instead of writing:
    #output["y"] = @. X["a"]*X["x"]^2 + X["b"]*X["x"] + X["c"]
    #we have:
    
    output["y"] = @. a*x^2 + b*x + c 

    output["a"] = a;
    output["b"] = b;
    output["c"] = c;

    

    return output
        
end

new_result = multiply_coefficients(equation)

@show a


using LinearAlgebra

x = 2

y = [1 2;3 4]

set_to_1(scal, matrix)= begin
                scal     = 1;
                matrix  .= 1;
                return scal, matrix    
            end

@show x 
@show y 

@show set_to_1(x, y)

@show x
@show y;

using LinearAlgebra

x = 2

y = [1 2;3 4]

set_to_1(scal, matrix)= begin
                scal     = 1;
                matrix_op = deepcopy(matrix) #new line
                matrix_op  .= 1; #we use `matrix_op` instead of `matrix`
                return scal, matrix_op    
            end

@show x 
@show y 

@show set_to_1(x, y)

@show x
@show y;

function Fun1(x::Float64,y::Float64)
    return(x-y)    
end

function Fun1(x::Array{Float64},y::Array{Float64})
    return(x .- y)    
end

Fun1([1; 2], [3; 2])

Fun1(3,2)
