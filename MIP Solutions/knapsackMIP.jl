# ====== Code by Igor Malheiros - May of 2019 ====== #
# ====== Knapsack Problem using Integer Programming ====== #

using JuMP, GLPK
using MathOptInterface # Replaces MathProgBase
const MOI = MathOptInterface

using GLPK # Loading the GLPK module for using its solver

struct Item
    name::String
    value::Int64
    weight::Int64
end

capacity = 10

itens = Item[]
push!(itens, Item("Diamond", 25, 1) )
push!(itens, Item("Book", 8, 3) )
push!(itens, Item("Sword", 12, 9) )
push!(itens, Item("Stone", 15, 3) )
push!(itens, Item("Statue", 12, 7) )
push!(itens, Item("Bracelet", 15, 4) )
push!(itens, Item("Crown", 9, 3) )
push!(itens, Item("Vase", 10, 8) )
push!(itens, Item("Skull", 5, 5) )

function solve(itens::Array{Item}, capacity::Int)
    load = 0

    model = Model(with_optimizer(GLPK.Optimizer));  
    @variable(model, x[1:length(itens)], Bin)

    @objective(model, Max, (i->i.value).(itens)' * x)

    @constraint(model, (i->i.weight).(itens)' * x <= capacity)

    JuMP.optimize!(model) # Old syntax: status = JuMP.solve(model)

    for i in 1:length(itens)
        if(value(x[i]) == 1.0)
            println(itens[i])
            load += itens[i].weight
        end
    end

    println("Load: ", load, "/", capacity)
    println(JuMP.objective_value(model))

    @show JuMP.has_values(model)
    @show JuMP.termination_status(model) == MOI.OPTIMAL
    @show JuMP.primal_status(model) == MOI.FEASIBLE_POINT

    @show JuMP.objective_value(model)
end


solve(itens, capacity)
  

