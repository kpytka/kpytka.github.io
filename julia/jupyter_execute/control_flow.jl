2 == 2

4>5

≈(2000, 2000.1, atol=.5)

≈(2000, 2000.1; atol=.0001)

x = [1,2]
y = x
z = deepcopy(x)

println("x==y: $(x==y)") #both objects have the same values
println("x==z: $(x==z)") #both objects have the same values
println("x===y: $(x===y)") #both objects refer to the same memory
println("x===z: $(x===z)") #both objects refer to different memory slots (even though they may have identical values)

(1:1:3) .== (3:-1:1) #comparing [1 2 3] with [3 2 1]. It's true only for 2nd elements

.![true, false] #notice the order of `.` and `!`

if 2!=2
    println("asd")
elseif 3>4
    println("3>4")
elseif 5==10
    println("5==10")
else
    println("nothing")
end

x = 4
even_x = x%2==0 ? "x is even" : "x is odd"

x = 4

x<5 ?  ( 
        x%2==0 ? println("x is smaller than 5 and is even") : #x<5 is true and x%2==0 is true
                 println("x is smaller than 5 and is odd")    #x<5 is true and x%2==0 is false
        ) :
         println("x is greater or equal to 5")                #x<5 is false and x%2==0 is not evaluated

x = collect( 1:10 );
result = ((x) .%2 .==0) .? -(x).^2 .: (x).^2.+1 

map(arg -> arg%2==0 ? -arg^2 : arg^2+1 , x)

(2+2==4) && println("(2+2==4) It's true");


(2+2==5) && println("(2+2==5) It's true"); # the latter is not executed as (2+2==5) is false

(2+2==4) || println("(2+2==4) It's false"); # the latter is not executed as (2+2==4) is true

(2+2==5) || println("(2+2==5) It's false");
