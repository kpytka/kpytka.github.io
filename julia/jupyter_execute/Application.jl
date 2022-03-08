α= .2

p(sₜ) = sₜ^(-α)
search = .01:.01:1

plot(search, p.(search))

yaxis!("p(sₜ)")
xaxis!("sₜ")



using Roots  #required by find_zero
using Printf #required by @sprintf
using Plots

Fun1(x)=x-x*√(x+1)+5

grid_points = 0:.1:10
fun_val=Array{Float64,1}(undef, length(grid_points))

for (count, arg)∈enumerate(grid_points)
    fun_val[count] = Fun1(arg)
end

map(Fun1,grid_points)



plot(grid_points, fun_val, label="function")
hline!([0], label="zero")

xₗ  = 0
xᵣ = 10
mid_point  = (xᵣ + xₗ)/2
Fun1(  xₗ  )*Fun1( xᵣ ) #it's negative

for i ∈ 1:100
    
    mid_point  = (xᵣ + xₗ)/2
    if Fun1(mid_point) * Fun1(  xₗ  ) < 0
         xᵣ = mid_point
    else
         xₗ = mid_point
    end
    println("i=$i, mid_point = $(round(mid_point, digits=3)), Fun1($(round(mid_point, digits=3))) = $(round(Fun1(mid_point), digits=3))")

    if abs(Fun1(mid_point)) < .001 #Tolerance error
        println(" 😃   abs(Fun1(mid_point))=$(abs(Fun1(mid_point))), which less than .001!!!")
        break
    end
    
end #i ∈ 1:100





plot(grid_points, fun_val, label="function")
hline!([0], label="zero")
vline!([mid_point], label="solution")



grid_points = 0:.1:20
fun_val=Array{Float64,1}(undef, length(grid_points))

for (count, arg)∈enumerate(grid_points)
    fun_val[count] = Fun1(arg)
end


plot(grid_points, fun_val, label="function")
hline!([0], label="zero")

xₗ  = Array{Float64, 1}(undef, 100)
xᵣ = Array{Float64, 1}(undef, 100)
mid_point = Array{Float64, 1}(undef, 100)

xₗ[1]   = 0 
xᵣ[1]  = 20
mid_point[1] = (xₗ[1] +xᵣ[1] )/2


for i ∈ 1:99

    if Fun1(mid_point[i]) * Fun1(  xₗ[i]  ) < 0
         xᵣ[i+1] = mid_point[i]
         xₗ[i+1] = xₗ[i]
    else
         xₗ[i+1] = mid_point[i]
         xᵣ[i+1] = xᵣ[i]
    end
    
    mid_point[i+1] = (xₗ[i+1] + xᵣ[i+1] )/2

    
    println("i=$i, mid_point = $(round(mid_point[i+1], digits=3)), Fun1($(round(mid_point[i+1], digits=3))) = $(round(Fun1(mid_point[i+1]), digits=3))")
    
    if abs(Fun1(mid_point[i+1])) < .001 #Tolerance error        
        println(" 😃   abs(Fun1(mid_point))=$(abs(Fun1(mid_point[i+1]))), which less than .001!!!")
        
        break
    end
    
end #i ∈ 1:100


anim = @animate for j∈1:10
    plot(grid_points, fun_val, label="function", xlim=[2.5 7.5])
    for i∈1:j
        annotate!([( mid_point[i], Fun1(mid_point[i]), "$i")])
    end
    hline!([0], label="zero")
end

gif(anim, "anim.gif", fps = 5)

solution = fzero(Fun1, 1)


Fun1(solution)

Fun1(x,y)=x-√(x+y)-3
Fun2(x,y)=y-√(x+1/y)-5

y0 = .7
x0 = fzero( x -> Fun1(x,y0), 1)
Fun1(x0,y0)


#But
Fun2(x0,y0)


y0 = fzero( y -> Fun2(x0,y), 1)

Fun2(x0,y0)
# Fun1(x0,y0)


Fun1(x0,y0)

y0 = .7
for i∈1:9
    global x0 = fzero( x -> Fun1(x,y0), 1)
    println("Iteration no. $i. x₀=$x0, y₀=$y0,")
    println("Iteration no. $i. Fun1(x0,y0)=$(Fun1(x0,y0)), Fun2(x0,y0)=$(Fun2(x0,y0))")
    println("---")
    global y0 = fzero( y -> Fun2(x0,y), 1)
    println("Iteration no. $i. x₀=$x0, y₀=$y0,")
    println("Iteration no. $i. Fun1(x0,y0)=$(Fun1(x0,y0)), Fun2(x0,y0)=$(Fun2(x0,y0))")
    println("================================================================")
end

Fun1(x0,y0)
Fun2(x0,y0)


# Parameters

α = .189 #price elasticity from Aguiar-Hurst (AER, 2007) https://www.aeaweb.org/articles?id=10.1257/aer.97.5.1533
δ = .33
L = 40
R = 10
y = 1
β = .8867 #.997^L


pR(cR) = (1/(1+cR/α))^(-α)
pW(cW) = ((1-δ)/(1+cW/α))^(-α)
cR(cW, cR) = √(β*pW(cW)/pR(cR)) * cW

cᴿ_value = .9 #Initial guess for retired consumption

#Implied value of working consumption given cᴿ_value:
cᵂ_value = fzero( cW -> pR(cR(cW,cᴿ_value))*cR(cW, cᴿ_value)*R + pW(cW)*cW*L-L*y, 1)

pR(cR(cᵂ_value,cᴿ_value))*cR(cᵂ_value, cᴿ_value)*R + pW(cᵂ_value)*cᵂ_value*L-L*y


#but cR(cᵂ_value , cᴿ_value) ≠ cᴿ_value --- contradiction
cR(cᵂ_value , cᴿ_value)


println("------------------------------------------")
println("👻 Iterative procedure STARTS:")
@time for i ∈ 1:7
    global cᵂ_value = fzero( cW -> pR(cR(cW,cᴿ_value))*cR(cW, cᴿ_value)*R + pW(cW)*cW*L-L*y, 1)
    global cᴿ_value = cR(cᵂ_value, cᴿ_value)
    println("Iteration No. $i, cᴿ=$(@sprintf("%.5f", cᵂ_value)), cᵂ=$(@sprintf("%.5f", cᴿ_value))")
end
println("------------------------------------------")


pR(cR(cᵂ_value,cᴿ_value))*cR(cᵂ_value, cᴿ_value)*R + pW(cᵂ_value)*cᵂ_value*L-L*y

cR(cᵂ_value , cᴿ_value)

println("Summary statistics:")
println("===================================================")
println("Retirement to working prices      💵   : $(@sprintf("%.4f",(pR(cR(cᵂ_value, cᴿ_value ))/pW(cᵂ_value)))).")
println("Retirement to working cons.       🍎   : $(@sprintf("%.4f",(cR(cᵂ_value,cᴿ_value)/cᵂ_value))).")
println("Retirement to working cons. exp.  💵🍎  : $(@sprintf("%.4f",(pR(cR(cᵂ_value,cᴿ_value))*cR(cᵂ_value,cᴿ_value)/(pW(cᵂ_value)*cᵂ_value)))).")
println("===================================================")



