# ====== Code by Igor Malheiros - July of 2019 ====== #
# ====== Travelling Salesman Problem using Integer Programming ====== #

using JuMP, GLPK
import MathOptInterface # Replaces MathProgBase
const MOI = MathOptInterface

#Data of points in a cartesian plan
# ### N = 12
# ### OBJ = 283.635
X = [43.0, 58.0, 53.0, 21.0, 78.0, 46.0, 79.0, 60.0, 42.0, 87.0, 77.0, 99.0]
Y = [23.0, 76.0, 64.0, 38.0, 68.0, 57.0,  6.0,  5.0, 30.0,  2.0, 97.0, 79.0]

# ### N = 48
# ### OBJ = 424.971
# X = [43.0, 58, 53, 21, 78, 46, 79, 60, 42, 87, 77, 99, 47, 59, 52, 29, 75, 41, 82, 66, 42, 88, 71, 89, 43, 28, 53, 24, 78, 46, 79, 60, 42, 85, 72, 91, 47, 53, 51, 20, 79, 48, 85, 66, 45, 82, 71, 84]
# Y = [23.0, 76, 64, 38, 68, 57, 6, 5, 30, 2, 97, 79, 21, 71, 54, 31, 65, 51, 1, 3, 36, 2, 91, 69, 53, 76, 44, 38, 38, 57, 16, 15, 30, 24, 97, 79, 22, 71, 54, 31, 61, 59, 11, 30, 34, 10, 90, 60]

#Build matrix of costs between points
function build_cost_matrix(X::Array{Float64}, Y::Array{Float64})
    N = length(X)
    cost_matrix = zeros(Float64, N, N)
    for i in 1:N
        for j in 1:N
            cost_matrix[i, j] = sqrt( (X[i]-X[j])^2 + (Y[i]-Y[j])^2)
        end
    end
    println(cost_matrix)
    return cost_matrix
end

function solve(c::Array{Float64, 2})
    N = size(c, 1)
    model = Model(with_optimizer(GLPK.Optimizer))

    @variable(model, x[1:N, 1:N], Bin)

    @objective(model, Min, sum(c[i, j] * x[i, j] for i in 1:N, j in 1:N if (i != j)) )

    for i in 1:N
        @constraint(model, sum(x[i, j] for j in 1:N if (i != j)) == 1)
    end

    for j in 1:N
        @constraint(model, sum(x[i, j] for i in 1:N  if (i != j)) == 1)
    end

    JuMP.optimize!(model)

    #There is no add lazy contraints for JuMP 0.19 yet...
    #This is a way to simulate:
    function subtour(model)
        x_val = value.(x)
        cycles = Int[]
        push!(cycles, 1)

        while true
            _, idx = findmax(x_val[cycles[end], 1:N])
            if (idx == cycles[1])
                break
            else
                push!(cycles, idx)
            end
        end

        println("cycle index: ", cycles, " cycle size: ", length(cycles))
        if (length(cycles) < N)
            @constraint(model, sum(x[cycles, cycles]) <= length(cycles) - 1)
            return false
        end
        return true
    end

    while (!subtour(model))
        JuMP.optimize!(model)
    end

    for i in 1:N
        for j in 1:N
            if (value(x[i,j]) == 1.0)
                println("Arc from: ", i, " to ", j, " with cost = ", c[i, j])
            end
        end
    end

    println("Total value: ", JuMP.objective_value(model))

    @show JuMP.has_values(model)
    @show JuMP.termination_status(model) == MOI.OPTIMAL
    @show JuMP.primal_status(model) == MOI.FEASIBLE_POINT
    @show JuMP.objective_value(model)

    return
end

c = build_cost_matrix(X,Y)
solve(c)