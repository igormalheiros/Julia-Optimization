# ====== Code by Igor Malheiros - June of 2019 ====== #
# ====== Cutting Stock Problem using Integer Programming ====== #


using JuMP, GLPK, Test
import MathOptInterface # Replaces MathProgBase
const MOI = MathOptInterface

struct Solution
    obj::Int
    x::Vector{Bool}
end

function solve(data::Data)
    n = data.n
    W = data.W
    v = data.v
    w = data.w

    model = Model(GLPK.Optimizer)

    @variable(model, x[1:n], Bin)

    @objective(model, Max, (sum(v[i] * x[i] for i = 1:n)))

    @constraint(model, sum(w[i] * x[i] for i = 1:n) <= W)

    JuMP.optimize!(model)

    solution = Solution(JuMP.objective_value(model), falses(n))

    for i = 1:n
        if value(x[i]) == 1.0
            solution.x[i] = true
        end
    end

    return solution
end
