# ====== Code by Igor Malheiros - June of 2019 ====== #
# ====== Cutting Stock Problem using Integer Programming ====== #


using JuMP, GLPK
import MathOptInterface # Replaces MathProgBase
const MOI = MathOptInterface

struct Order
    id::Int
    size::Float64
    demand::Int64
end

len = 11
ub = 22

orders = Order[]
push!(orders, Order(1, 2, 8))
push!(orders, Order(2, 3.5, 6))
push!(orders, Order(3, 3, 5))
push!(orders, Order(4, 4, 3))

function solve(orders::Array{Order}, len::Int, n::Int)
    m = length(orders)

    model = Model(GLPK.Optimizer)

    @variable(model, y[1:n], Bin)
    @variable(model, x[1:n, 1:m] >= 0, Int)

    @objective(model, Min, sum(y[i] for i = 1:n))

    for j = 1:m
        @constraint(model, sum(x[i, j] for i = 1:n) >= orders[j].demand)
    end

    for i = 1:n
        @constraint(model, sum(orders[j].size * x[i, j] for j = 1:m) <= len * y[i])
    end

    JuMP.optimize!(model) # Old syntax: status = JuMP.solve(model)

    for i = 1:n
        if (value(y[i]) == 1.0)
            println("Bar #", i)
            used = 0
            for j = 1:m
                if (value(x[i, j]) > 0)
                    println(
                        "Order #",
                        j,
                        " has size of ",
                        orders[j].size,
                        " and appears ",
                        value(x[i, j]),
                        " times",
                    )
                    used += (orders[j].size * value(x[i, j]))
                end
            end
            println("Total used: ", used, "/", len)
        end
    end

    println()

    @show JuMP.has_values(model)
    @show JuMP.termination_status(model) == MOI.OPTIMAL
    @show JuMP.primal_status(model) == MOI.FEASIBLE_POINT
    @show JuMP.objective_value(model)

    return
end

solve(orders, len, ub)
