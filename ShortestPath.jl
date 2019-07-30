# ====== Code by Igor Malheiros - July of 2019 ====== #
# ====== Shortest Path using Bellman-Ford algorithm ====== #

const graph = Tuple{Int, Int, Float64}[]

function add_edge(u::Int, v::Int, w::Float64)
    push!(graph, (u, v, w) )
end

function print_graph()
    for (u, v, w) in graph
        println("From ", u, " to ", v, " has cost of ", w)    
    end
end

function bellmanford(V::Int, source::Int, target::Int)
    println("==== BELLMAN-FORD ALGORITHM ====")

    dist = fill(100000.0, V)
    bestEdges = fill( (0,0, 0.0), 10)
    bestEdges[source] = (source, source, 0.0)
    dist[source] = 0

    for i in 1:V
        for j in 1:length(graph)
            edge = graph[j]
            if (edge[2] == i)
                if (dist[i] > dist[edge[1]] + edge[3])
                    dist[i] = dist[edge[1]] + edge[3]
                    bestEdges[i] = edge
                end
            end
        end
    end

    println("==== SHORTEST PATH ====")
    println("Source: ", source)
    println("Cost to ", target, " : ", dist[target])
    for (u, v, w) in bestEdges
        println(u, " to ", v, " with weight = ", w)
    end
end

V = 10
add_edge(1, 2, 10.0) 
add_edge(1, 3, 6.0) 
add_edge(1, 4, 5.0) 
add_edge(2, 4, 15.0) 
add_edge(3, 4, 4.0) 
add_edge(4, 5, 2.5) 
add_edge(4, 6, 9.0) 
add_edge(3, 5, 4.5)
add_edge(1, 6, 11.0)  
add_edge(6, 7, 1.5)
add_edge(7, 8, 3.5) 
add_edge(6, 8, 5.0)
add_edge(8, 9, 7.5)
add_edge(8, 10, 12.0)
add_edge(3, 10, 17.0)
add_edge(5, 9, 9.0)
add_edge(9, 10, 4.5)  
print_graph()
bellmanford(V, 1, 10)