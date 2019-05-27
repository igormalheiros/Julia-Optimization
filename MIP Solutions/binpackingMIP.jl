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
push!(itens, Item("Portrait", 13, 6) )
push!(itens, Item("Ring", 20, 2) )
push!(itens, Item("Medal", 17, 3) )
push!(itens, Item("Mummy", 19, 10) )
push!(itens, Item("Watch", 12, 4) )
push!(itens, Item("Golden Coins", 20, 5) )


function solve(itens, capacity)
    n = length(itens)
    load = 0

    model = Model(with_optimizer(GLPK.Optimizer));  
    @variable(model, x[1:n, 1:n], Bin)
    @variable(model, y[1:n], Bin)

    @objective(model, Min, sum(y[i] for i in 1:n))

    for i in 1:n
        @constraint(model, sum(itens[j].weight * x[i, j] for j in 1:n) <= capacity * y[i])
    end

    for j in 1:n
        @constraint(model, sum(x[i, j] for i in 1:n) == 1)
    end


    JuMP.optimize!(model) # Old syntax: status = JuMP.solve(model)

    for i in 1:n
        if (value(y[i]) == 1.0)
            println("Bin Number ", i)
            load = 0
            for j in 1:n
                if (value(x[i,j]) == 1.0)
                    println(itens[j])
                    load += itens[j].weight
                end
            end
            println("Load: ", load, "/", capacity, "\n")
        end
    end

    println("Total of Bins used: ", JuMP.objective_value(model))

    @show JuMP.has_values(model)
    @show JuMP.termination_status(model) == MOI.OPTIMAL
    @show JuMP.primal_status(model) == MOI.FEASIBLE_POINT

    @show JuMP.objective_value(model)
end


solve(itens, capacity)
  

