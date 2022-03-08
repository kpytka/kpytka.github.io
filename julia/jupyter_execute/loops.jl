for i in [1 2 3 4]
    println("i=$i")
end

A = [1 2; 3 4]

for i in A
    println("i=$i")
end

for x ∈ 1:3
    for y ∈ 1:2
        println("x^y=$(x^y), for x=$x and y=$y.")
    end     
end

for x ∈ 1:3, y ∈ 1:2    
        println("x^y=$(x^y), for x=$x and y=$y.")    
end

x = collect(1:10)
y = similar(x) #the object of the same size and type as x 

for i ∈ 1:length(x)    
    y[i] = x[i]%2==0 ? -x[i]^2 : x[i]^2+1

end

println("y=$y")



y2 = similar(x)
for (i,xᵢ) ∈   enumerate(x)
    y2[i] = xᵢ%2==0 ? -xᵢ^2 : xᵢ^2+1
end

println("y2=$y2")

y = [ xᵢ%2==0 ? -xᵢ^2 : xᵢ^2+1 for xᵢ ∈ x ]

i = 0
while i ≤ 5    
    println("i=$i")
    i+=1;
    
end

i = 0
for κ ∈ 1:1000
    println("i=$i")
    i+=1;
    if i>5 #termination condition
        break
    end 
end


i = 0
for κ ∈ 1:1000
    println("i=$i")
    i+=1;
    if i≤5 
        continue 
    else
        break
    end 
    
    1+2+3 #this part of the loop is never executed.
    
end


i = 0
for κ ∈ 1:1000
    println("i=$i")
    i+=1;
    
    i≤5 || break #termination condition. `break` is executed when `i≤5` is false
            
end
