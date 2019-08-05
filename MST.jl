# ====== Code by Igor Malheiros - June of 2019 ====== #
# ====== Minimum Spanning Tree using Kruskal's and Prim's algorithm ====== #

const graph = Tuple{Int, Int, Float64}[]

function add_edge(u::Int, v::Int, w::Float64)
    push!(graph, (u, v, w) )
    return
end

function print_graph()
    for (u, v, w) in graph
        println("From ", u, " to ", v, " has cost of ", w)    
    end
    return
end

function find(u::Int, parent::Array{Int})
    if (u == parent[u])
        return u
    end
    return find(parent[u], parent)
end

function union(u::Int, v::Int, parent::Array{Int}, rank::Array{Int})
   u_root = find(u, parent) 
   v_root = find(v, parent)

    if (rank[u_root] < rank[v_root])
        parent[u_root] = v_root
    elseif (rank[v_root] < rank[u_root])
        parent[v_root] = u_root
    else 
        parent[v_root] = u_root
        rank[v_root] += 1
    end
    return
end

function kruskal(V::Int)
    println("\n==== KRUSKAL ALGORITHM ====")
    mst = Tuple{Int, Int, Float64}[]

    parent = Int[]
    rank = Int[]

    e = 0
    i = 1
    mst_cost = 0
    
    sort!(graph, by = edge -> edge[3])

    for i in 1:V
        push!(parent, i)
        push!(rank, 0)
    end

    while (e < V-1)
        small_edge = graph[i]
        i += 1
        u = find(small_edge[1], parent)
        v = find(small_edge[2], parent)

        if (u != v)
            e += 1
            union(u, v, parent, rank)
            push!(mst, small_edge)
            mst_cost += small_edge[3]
        end
    end

    println("==== MST ====")
    println("Cost: ", mst_cost)

    for (u, v, w) in mst
        println("The edge from ", u, " to ", v, " with cost: ", w)
    end
    return
end

function get_adj_list(V::Int)
    adj_list = Array{Tuple{Int, Float64}}[]
    for node in 1:V
        push!(adj_list, [])
        for (u, v, w) in graph
            if (u == node)
                push!(adj_list[node], (v, w) )
            elseif (v == node)
                push!(adj_list[node], (u, w) )
            end
        end
    end

    return adj_list
end

function min_key(V::Int, key::Array{Float64}, mstSet::Array{Bool})
    min = Inf
    min_index = 1

    for u in 1:V
        if (key[u] < min && !mstSet[u])
            min = key[u]
            min_index = u
        end
    end

    return min_index
end

function prim(V::Int, adj_list::Array{Array{Tuple{Int, Float64}}})
    println("\n==== PRIM ALGORITHM ====")
    mstSet = Bool[]
    key = Float64[]
    parent = Int[]
    mst_cost = 0

    for v in 1:V 
        push!(key, Inf)
        push!(mstSet, false)
        push!(parent, 0)
    end

    key[1] = 0

    for node in 1:V
        u = min_key(V, key, mstSet)

        mstSet[u] = true
        mst_cost += key[u]

        for (v, w) in adj_list[u]
            if ( !mstSet[v] && key[v] > w)
                key[v] = w
                parent[v] = u
            end
        end
    end

    println("==== MST ====")
    println("Cost: ", mst_cost)
    for node in 2:V
        println("The edge from ", node, " to ", parent[node])
    end
    return
end

V = 4
add_edge(1, 2, 10.0) 
add_edge(1, 3, 6.0) 
add_edge(1, 4, 5.0) 
add_edge(2, 4, 15.0) 
add_edge(3, 4, 4.0) 
print_graph()
adj_list = get_adj_list(V)
kruskal(V)
prim(V, adj_list)