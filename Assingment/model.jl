# ====== Code by Igor Malheiros - June of 2019 ====== #
# ====== Assignment Problem using Integer Programming ====== #

using JuMP, GLPK, Test
import MathOptInterface # Replaces MathProgBase
const MOI = MathOptInterface

struct Solution
    obj::Float64
    x::Matrix{Bool}
end

function solve(data::Data)
    n = data.n
    c = data.c

    model = Model(GLPK.Optimizer)
    @variable(model, x[1:n, 1:n], Bin)

    @objective(model, Min, sum(c[i, j] * x[i, j] for i = 1:n, j = 1:n))

    for i = 1:n
        @constraint(model, sum(x[i, j] for j = 1:n) == 1)
    end

    for j = 1:n
        @constraint(model, sum(x[i, j] for i = 1:n) == 1)
    end

    JuMP.optimize!(model)

    solution = Solution(JuMP.objective_value(model), falses(n, n))

    for i = 1:n
        for j = 1:n
            solution.x[i, j] = value(x[i, j]) == 1.0 ? true : false
        end
    end

    return solution
end
