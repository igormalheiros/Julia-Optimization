# ====== Code by Igor Malheiros - June of 2019 ====== #
# ====== Cutting Stock Problem using Integer Programming ====== #


using JuMP, GLPK, Test
import MathOptInterface # Replaces MathProgBase
const MOI = MathOptInterface

struct Solution
    obj::Int
    y::Array{Bool,1}
    x::Matrix{Bool}
end

function solve(data::Data)
    I = data.I
    J = data.J
    f = data.f
    q = data.q
    Q = data.Q
    c = data.c

    model = Model(GLPK.Optimizer)

    @variable(model, y[1:I], Bin)
    @variable(model, x[1:I, 1:J], Bin)

    @objective(
        model,
        Min,
        (sum(f[i] * y[i] for i = 1:I) + sum(c[i, j] * x[i, j] for i = 1:I, j = 1:J))
    )

    for j = 1:J
        @constraint(model, sum(x[i, j] for i = 1:I) == 1)
    end

    for i = 1:I
        @constraint(model, sum(q[j] * x[i, j] for j = 1:J) <= (Q[i] * y[i]))
    end

    JuMP.optimize!(model)

    solution = Solution(JuMP.objective_value(model), falses(I), falses(I, J))

    for i = 1:I
        if value(y[i]) == 1.0
            solution.y[i] = true
            for j = 1:J
                if value(x[i, j]) == 1.0
                    solution.x[i, j] = true
                end
            end
        end
    end

    return solution
end
