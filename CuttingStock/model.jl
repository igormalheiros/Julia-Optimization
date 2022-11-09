# ====== Code by Igor Malheiros - June of 2019 ====== #
# ====== Cutting Stock Problem using Integer Programming ====== #


using JuMP, GLPK, Test
import MathOptInterface # Replaces MathProgBase
const MOI = MathOptInterface

struct Solution
    obj::Int
    y::Array{Bool,1}
    x::Matrix{Int}
end

function solve(data::Data)
    L = data.L
    n = data.n
    m = data.m
    l = data.l
    b = data.b

    model = Model(GLPK.Optimizer)

    @variable(model, y[1:n], Bin)
    @variable(model, x[1:n, 1:m] >= 0, Int)

    @objective(model, Min, sum(y[i] for i = 1:n))

    for j = 1:m
        @constraint(model, sum(x[i, j] for i = 1:n) >= b[j])
    end

    for i = 1:n
        @constraint(model, sum(l[j] * x[i, j] for j = 1:m) <= L * y[i])
    end

    JuMP.optimize!(model)

    solution = Solution(JuMP.objective_value(model), falses(n), falses(n, n))

    for i = 1:n
        if value(y[i]) == 1.0
            solution.y[i] = true
            for j = 1:m
                solution.x[i, j] = value(x[i, j])
            end
        end
    end

    return solution
end
