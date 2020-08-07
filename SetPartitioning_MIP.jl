# ====== Code by Igor Malheiros - August of 2019 ====== #
# ====== Set Partitioning Problem using Integer Programming ====== #

using JuMP, GLPK
import MathOptInterface
const MOI = MathOptInterface

function solve(sets::Array{Array{Int,1},1}, max_value::Int, n_sets::Int)
    model = Model(with_optimizer(GLPK.Optimizer));
    @variable(model, y[1:n_sets], Bin)

    @objective(model, Min, sum(y[i] for i in 1:n_sets))

    for v in 1:max_value
        @constraint(model, sum(y[i] for i in 1:n_sets if v in sets[i]) == 1)
    end

    JuMP.optimize!(model)

    for i in 1:n_sets
        if (value(y[i]) == 1.0)
            println("Set: ", sets[i], " is part of partitioning")
        end
    end

    println("\nTotal of sets: ", JuMP.objective_value(model),"\n")

    @show JuMP.has_values(model)
    @show JuMP.termination_status(model) == MOI.OPTIMAL
    @show JuMP.primal_status(model) == MOI.FEASIBLE_POINT
    @show JuMP.objective_value(model)

    println("\n")
    return
end

max_value = 5
n_sets = 6
sets = [[1, 2], [1,3,5], [2,4,5], [3], [1], [4,5]]

println("Sets: ")
for i in 1:n_sets
    println(sets[i])
end
println()

solve(sets, max_value, n_sets)
