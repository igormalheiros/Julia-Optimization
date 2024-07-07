import Pkg
Pkg.add("JuMP")
Pkg.add("CPLEX")
Pkg.add("MathOptInterface")

using JuMP, CPLEX, Test
import MathOptInterface # Replaces MathProgBase
const MOI = MathOptInterface

struct Route
    sequence::Vector{Int}
    arrivals::Vector{Float64}
    demands::Vector{Int}
end

struct Solution
    obj::Float64
    routes::Vector{Route}
end

function build_solution(x::Array{Bool, 3}, data::Data)
    n = data.n
    v = data.v
    e = data.e
    s = data.s
    t = data.t
    q = data.q
    K = 1:v
    mo = 2*n + 1
    me = 2*n + 2

    routes = Vector{Route}()
    for k in K
        # first depot
        i = mo
        sequence = [i]
        arrivals = [e[i]]
        demands = [q[i]]

        # sequence of customers
        i = findfirst(a -> a == 1, x[i, :, k])

        while i != me
            push!(sequence, i)
            push!(arrivals, max(e[i], arrivals[end] + s[i] + t[sequence[end-1], i]))
            push!(demands, demands[end] + q[i])
            i = findfirst(a -> a == 1, x[i, :, k])
        end

        # last depot
        push!(sequence, me)
        push!(arrivals, max(e[me], arrivals[end] + s[me]))
        push!(demands, demands[end] + q[me])

        push!(routes, Route(sequence, arrivals, demands))
    end
    return routes
end

function solve(data::Data)
    n = data.n
    v = data.v
    C = data.C
    L = data.L
    e = data.e
    l = data.l
    s = data.s
    t = data.t
    c = data.c
    T = data.T
    q = data.q

    V = 1:(2*(n+1))
    P = 1:n
    K = 1:v
    PUD = 1:(2*n)
    mo = 2*n + 1
    me = 2*n + 2
    M1 = T
    M2 = C

    model = Model(CPLEX.Optimizer)

    @variable(model, x[i in V, j in V, K; i != j], Bin)
    @variable(model, u[V, K] >= 0)
    @variable(model, w[V, K] >= 0)
    @variable(model, r[P, K] >= 0)

    @objective(model, Min, sum(c[i, j] * x[i, j, k] for i = V, j = V, k = K if i != j))
    @constraint(model, [i = P], sum(x[i, j, k] for j = V, k = K if i != j) == 1)
    @constraint(model, [k = K], sum(x[mo, j, k] for j = V if mo != j) == 1)
    @constraint(model, [k = K], sum(x[i, me, k] for i = V if i != me) == 1)
    @constraint(model, [i = P, k = K], sum(x[i, j, k] for j = V if i != j) - sum(x[i+n, j, k] for j = V if (i+n) != j) == 0)
    @constraint(model, [i = PUD, k = K], sum(x[j, i, k] for j = V if i != j) - sum(x[i, j, k] for j = V if i != j) == 0)
    @constraint(model, [i = V, j = V, k = K; i != j], u[j, k] >= (u[i, k] + s[i] + t[i, j]) - M1*(1 - x[i, j, k]))
    @constraint(model, [i = V, j = V, k = K; i != j], w[j, k] >= (w[i, k] + q[j]) - M2*(1 - x[i, j, k]))
    @constraint(model, [i = P, k = K], r[i, k] >= u[i+n, k] - (u[i, k] + s[i]))
    @constraint(model, [k = K], u[me, k] - u[mo, k] <= T)
    @constraint(model, [i = V, k = K], u[i, k] >= e[i])
    @constraint(model, [i = V, k = K], u[i, k] <= l[i])
    @constraint(model, [i = P, k = K], u[i + n, k] >= u[i, k])
    @constraint(model, [i = P, k = K], r[i, k] >= t[i, i+n])
    @constraint(model, [i = P, k = K], r[i, k] <= L)
    @constraint(model, [i = V, k = K], w[i, k] >= max(0, q[i]))
    @constraint(model, [i = V, k = K], w[i, k] <= min(C, C + q[i]))


    JuMP.optimize!(model)
    x_values = JuMP.value.(x)
    
    # Retrieving solution
    x_bools = Array{Bool}(undef, (2*(n+1)), (2*(n+1)), v)
    for k in K    
        for i in V
            for j in V
                if i != j
                    x_bools[i, j, k] = round(Int, x_values[i, j, k]) == 1
                else 
                    x_bools[i, j, k] = false
                end
            end
        end
    end
    return Solution(JuMP.objective_value(model), build_solution(x_bools, data))
end