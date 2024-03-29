# ====== Code by Igor Malheiros - May of 2019 ====== #
# ====== Bin Packing Problem using Integer Programming ====== #

using JuMP, GLPK, Test
import MathOptInterface # Replaces MathProgBase
const MOI = MathOptInterface

struct Solution
    obj::Int
    y::Array{Bool,1}
    x::Matrix{Bool}
end

function solve(data::Data)
    n = data.n
    W = data.W
    w = data.w

    model = Model(GLPK.Optimizer)

    @variable(model, x[1:n, 1:n], Bin)
    @variable(model, y[1:n], Bin)

    @objective(model, Min, sum(y[i] for i = 1:n))

    for i = 1:n
        @constraint(model, sum(w[j] * x[i, j] for j = 1:n) <= W * y[i])
    end

    for j = 1:n
        @constraint(model, sum(x[i, j] for i = 1:n) == 1)
    end

    JuMP.optimize!(model)

    solution = Solution(JuMP.objective_value(model), falses(n), falses(n, n))

    for i = 1:n
        if value(y[i]) == 1.0
            solution.y[i] = true
            for j = 1:n
                solution.x[i, j] = (value(x[i, j]) == 1.0) ? true : false
            end
        end
    end

    return solution
end
