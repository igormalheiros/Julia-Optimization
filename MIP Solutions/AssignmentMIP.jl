# ====== Code by Igor Malheiros - May of 2019 ====== #
# ====== Assignment Problem using Integer Programming ====== #

using JuMP, GLPK
using MathOptInterface # Replaces MathProgBase
const MOI = MathOptInterface

using GLPK # Loading the GLPK module for using its solver

#C = [9 2 7 8; 6 4 3 7 ; 5 8 1 8; 7 6 9 4]
C = [2500 4000 3500 ; 4000 6000 3500 ; 2000 4000 2500]

function solve(cost_matrix::Array{Int,2}, N::Int)
    model = Model(with_optimizer(GLPK.Optimizer))
    @variable(model, x[1:N, 1:N], Bin)

    @objective(model, Min, sum(cost_matrix[i,j] * x[i, j] for i in 1:N, j in 1:N) )

    for i in 1:N
        @constraint(model, sum(x[i, j] for j in 1:N) == 1 )
    end

    for j in 1:N
        @constraint(model, sum(x[i, j] for i in 1:N) == 1 )
    end

    JuMP.optimize!(model) # Old syntax: status = JuMP.solve(model)


    for i in 1:N
        for j in 1:N
            if (value(x[i,j]) == 1.0)
                println("Agent: ", i, " assigned to task ", j, " with cost = ", C[i, j])
            end
        end
    end

    println("Total value: ", JuMP.objective_value(model))

    @show JuMP.has_values(model)
    @show JuMP.termination_status(model) == MOI.OPTIMAL
    @show JuMP.primal_status(model) == MOI.FEASIBLE_POINT

    @show JuMP.objective_value(model)

end

solve(C, size(C)[1])