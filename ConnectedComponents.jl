# ====== Code by Igor Malheiros - June of 2019 ====== #
# ====== Find Connected Components in a Graph using ====== #
# ====== Depth First Search and Breadth First Search ====== #

const people = [:Maria, :Manuel, :Michel, :Igor, :Ian, :Iago, :Andrea, :Amanda, :Arthur, :Afonso ]
const friendship = [
           (:Maria, :Manuel),
           (:Michel, :Manuel),
           (:Igor, :Ian),
           (:Ian, :Iago),
           (:Andrea, :Amanda),
           (:Arthur, :Afonso),
           (:Andrea, :Afonso),
       ]

adj_list = Dict(p => eltype(people)[] for p in people)
for (a, b) in friendship
    push!(adj_list[a], b)
    push!(adj_list[b], a)
end

function dfs(adj_list::Dict{Symbol, Array{Symbol, 1}}, source::Symbol, visit::Dict{Symbol, Bool})
    println(source)
    for p in adj_list[source]
        if (!visit[p])
            visit[p] = true
            dfs(adj_list, p, visit)
        end
    end

    return
end

function bfs(adj_list::Dict{Symbol, Array{Symbol, 1}}, source::Symbol, visit::Dict{Symbol, Bool})
    println(source)
    queue = [source]
    while !isempty(queue)
        current = popfirst!(queue)
        for p in adj_list[current]
            if (!visit[p])
                println(p)
                visit[p] = true
                push!(queue, p)
            end
        end
    end
    return
end

function find_components(adj_list::Dict{Symbol, Array{Symbol, 1}})
    println("======== DFS ========")
    visit = Dict(p => false for p in people)
    component = 0
    for p in people
        if (!visit[p])
            component += 1
            println("Coponent: ", component)
            visit[p] = true
            dfs(adj_list, p, visit)
        end
    end

    println("======== BFS ========")
    visit = Dict(p => false for p in people)
    component = 0
    for p in people
        if (!visit[p])
            component += 1
            println("Coponent: ", component)
            visit[p] = true
            bfs(adj_list, p, visit)
        end
    end

    return
end

find_components(adj_list)