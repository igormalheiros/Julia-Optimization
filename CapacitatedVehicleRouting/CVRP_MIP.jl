# ====== Code by Igor Malheiros - April of 2026 ====== #
# ====== Capacitated Vehicle Routing Problem using Integer Programming ====== #

using JuMP, Gurobi, LightGraphs, LightGraphsFlows, OffsetArrays
import MathOptInterface # Replaces MathProgBase
const MOI = MathOptInterface

#Data of points in a cartesian plan
X = Dict(0 => 50.0, 1 => 40.0, 2 => 30.0, 3 => 20.0, 4 => 10.0)
Y = Dict(0 => 50.0, 1 => 40.0, 2 => 60.0, 3 => 50.0, 4 => 30.0)
q = Dict(0 => 0, 1 => 3, 2 => 1, 3 => 4, 4 => 1)
Q = 5
n = length(X)
V = 0:n-1
N = 1:n-1

#Build matrix of costs between points
function build_cost_matrix(X::Dict{Int,Float64}, Y::Dict{Int,Float64})
    cost_matrix = OffsetArray(zeros(Float64, n, n), V, V)
    for i = V
        for j = V
            cost_matrix[i, j] = sqrt((X[i] - X[j])^2 + (Y[i] - Y[j])^2)
        end
    end
    println(cost_matrix)
    return cost_matrix
end

#Build matrix of costs between points
function build_cost_matrix_manh(X::Dict{Int,Float64}, Y::Dict{Int,Float64})
    cost_matrix = OffsetArray(zeros(Float64, n, n), V, V)
    for i = V
        for j = V
            cost_matrix[i, j] = abs(X[i] - X[j]) + abs(Y[i] - Y[j])
        end
    end
    println(cost_matrix)
    return cost_matrix
end

function bound_vehicles(q::Dict{Int,Int}, Q::Int)
    return 1:Int(ceil(sum(values(q)) / Q))
end

function solve(c::OffsetArray{Float64,2}, q::Dict{Int,Int}, Q::Int)
    K = bound_vehicles(q, Q)
    println("Using Flow variable Modelling")

    model = Model(Gurobi.Optimizer)

    # Arcs variables
    @variable(model, x[i=V, j=V, k=K; i != j], Bin)
    # Load variables
    @variable(model, y[i=N, k=K], Bin)

    # Objective function
    @objective(model, Min, sum(c[i, j] * x[i, j, k] for k in K, i in V, j in V if (i != j)))

    # Visiting constraints
    @constraint(model, [i in N], sum(y[i, k] for k in K) == 1)

    # Flow constraints
    @constraint(model, [i in N, k in K], sum(x[i, j, k] for j in V if (i != j)) == y[i, k])
    @constraint(model, [j in N, k in K], sum(x[i, j, k] for i in V if (i != j)) == y[j, k])

    # Depot constraints
    @constraint(model, [k in K], sum(x[0, j, k] for j in V if (0 != j)) == 1)
    @constraint(model, [k in K], sum(x[i, 0, k] for i in V if (i != 0)) == 1)

    # Capacity constraints
    @constraint(model, [k in K], sum(q[i] * y[i, k] for i in N) ≤ Q)

    # Subtour elimination constraints
    function kSEC_callback(cb_data)
        EPS = 1e-5
        VIOLA = 1e-4
        x_val = callback_value.(cb_data, x)
        y_val = callback_value.(cb_data, y)
        weight = zeros(Float64, n, n)

        for k in K
            G = LightGraphs.SimpleDiGraph(n)
            for i in V
                for j in V
                    if (i != j && x_val[i, j, k] > EPS)
                        LightGraphs.add_edge!(G, i+1, j+1)
                        weight[i+1, j+1] = x_val[i, j, k]
                    end
                end
            end
            for i in N
                if (y_val[i, k] > VIOLA)
                    fval, _, labels = LightGraphsFlows.maximum_flow(G, 1, i+1, weight, algorithm=BoykovKolmogorovAlgorithm())
                    if fval < y_val[i, k] - VIOLA
                        S = Set()
                        T = Set()
                        for j in V
                            if (labels[j+1] == labels[i+1])
                                push!(S, j)
                            else
                                push!(T, j)
                            end
                            cut = @build_constraint(sum(x[u, v, k] for u in S, v in T) >= y[i, k])
                            MOI.submit(model, MOI.LazyConstraint(cb_data), cut)
                        end
                    end
                end
            end
        end
    end
    MOI.set(model, MOI.LazyConstraintCallback(), kSEC_callback)
    
    JuMP.optimize!(model)

    for k in K
        println("Route for vehicle ", k, ":")
        cost = 0
        for i in V
            for j in V
                if (i != j && value(x[i, j, k]) >= 0.75)
                    println("Arc from: ", i, " to ", j, " with cost = ", c[i, j])
                    cost += c[i, j]
                end
            end
        end
        println("Cost for vehicle ", k, ": ", cost)
    end

    for k in K
        load = 0
        for i in N
            if (value(y[i, k]) >= 0.75)
                load += q[i]
                println("Customer ", i, " is served by vehicle ", k)
            end
        end
        println("Load for vehicle ", k, ": ", load, "/", Q)
    end
    
    println("================================")
    println("Total value: ", JuMP.objective_value(model))

    @show JuMP.has_values(model)
    @show JuMP.termination_status(model) == MOI.OPTIMAL
    @show JuMP.primal_status(model) == MOI.FEASIBLE_POINT
    @show JuMP.objective_value(model)

    return
end

c = build_cost_matrix_manh(X, Y)
@time solve(c, q, Q)