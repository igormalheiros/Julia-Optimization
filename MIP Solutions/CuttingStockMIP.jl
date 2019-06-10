using JuMP, GLPK
using MathOptInterface # Replaces MathProgBase
const MOI = MathOptInterface

using GLPK # Loading the GLPK module for using its solver

struct Order
    id::Int
    size::Float64
    demand::Int64
end

length = 11
upperBound = 22

orders = Order[]
push!(orders, Order(1, 2, 8))
push!(orders, Order(2, 3.5, 6))
push!(orders, Order(3, 3, 5))
push!(orders, Order(4, 4, 3))

function solve(orders::Array{Order}, length::Int, n::Int)
    m = size(orders)[1]

    model = Model(with_optimizer(GLPK.Optimizer));  

    @variable(model, y[1:n], Bin)
    @variable(model, x[1:n, 1:m] >= 0, Int)

    @objective(model, Min, sum(y[i] for i in 1:n))

    for j in 1:m
        @constraint( model, sum( x[i, j] for i in 1:n ) >= orders[j].demand )
    end

    for i in 1:n
        @constraint( model, sum( orders[j].size * x[i, j] for j in 1:m) <= length * y[i] )
    end

    JuMP.optimize!(model) # Old syntax: status = JuMP.solve(model)

    for i in 1:n
        if (value(y[i]) == 1.0)
            println("Bar #", i)
            used = 0
            for j in 1:m
                if (value(x[i, j]) > 0)
                    println("Order #", j, " has size of ", orders[j].size, " and appears ", value(x[i, j]), " times")
                    used += (orders[j].size * value(x[i, j]))
                end
            end
            println("Total used: ", used, "/", length)
        end
    end

    println()

    @show JuMP.has_values(model)
    @show JuMP.termination_status(model) == MOI.OPTIMAL
    @show JuMP.primal_status(model) == MOI.FEASIBLE_POINT

    @show JuMP.objective_value(model)

end

solve(orders, length, upperBound)