# ====== Code by Igor Malheiros - May of 2019 ====== #
# ====== Bin Packing Problem using Integer Programming ====== #

using JuMP, GLPK, Test
import MathOptInterface # Replaces MathProgBase
const MOI = MathOptInterface

struct Data
    n::Int
    W::Int
    w::Vector{Int}
end

struct Solution
    obj::Float64
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

function print_solution(data::Data, solution::Solution)
    println("******** Printing Solution! ********\n")

    for i = 1:data.n
        if solution.y[i]
            println("New Bin")
            load = 0
            for j = 1:data.n
                if solution.x[i, j]
                    println("Including item ", j, " with weight: ", data.w[j])
                    load += data.w[j]
                end
            end
            println("Load: ", load, "/", data.W, "\n")
        end
    end
    println("Obj Function: ", solution.obj)
    println("******** End of Printing! ********\n")
    return
end

data_1 = Data(15, 10, [1, 3, 9, 3, 7, 4, 3, 8, 5, 6, 2, 3, 10, 4, 5])
data_2 = Data(10, 20, [8, 13, 20, 4, 6, 2, 5, 12, 9, 5])

benchmark_1 = 8
benchmark_2 = 5

solution_1 = solve(data_1)
solution_2 = solve(data_2)

@test solution_1.obj == benchmark_1
@test solution_2.obj == benchmark_2

print_solution(data_1, solution_1)
print_solution(data_2, solution_2)
