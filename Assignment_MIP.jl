# ====== Code by Igor Malheiros - June of 2019 ====== #
# ====== Assignment Problem using Integer Programming ====== #

using JuMP, GLPK, Test
import MathOptInterface # Replaces MathProgBase
const MOI = MathOptInterface

struct Data
    n::Int
    c::Matrix{Int}
end

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

function print_solution(data::Data, solution::Solution)
    println("******** Printing Solution! ********\n")

    for i = 1:data.n
        for j = 1:data.n
            if solution.x[i, j]
                println(
                    "Agent: ",
                    i,
                    " assigned to task ",
                    j,
                    " with cost = ",
                    data.c[i, j],
                )
            end
        end
    end
    println("Obj Function: ", solution.obj)
    println("******** End of Printing! ********\n")
    return
end

data_1 = Data(4, [9 2 7 8; 6 4 3 7; 5 8 1 8; 7 6 9 4])
data_2 = Data(3, [2500 4000 3500; 4000 6000 3500; 2000 4000 2500])

benchmark_1 = 13
benchmark_2 = 9500

solution_1 = solve(data_1)
solution_2 = solve(data_2)

@test solution_1.obj == benchmark_1
@test solution_2.obj == benchmark_2

print_solution(data_1, solution_1)
print_solution(data_2, solution_2)
