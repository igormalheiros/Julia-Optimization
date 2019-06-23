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

adjList = Dict(p => eltype(people)[] for p in people)
for (a, b) in friendship
    push!(adjList[a], b)
    push!(adjList[b], a)
end

function dfs(adjList::Dict{Symbol, Array{Symbol, 1}}, source::Symbol, visit::Dict{Symbol, Bool})
    println(source)
    for p in adjList[source]
        if (!visit[p])
            visit[p] = true
            dfs(adjList, p, visit)
        end
    end
end

function bfs(adjList::Dict{Symbol, Array{Symbol, 1}}, source::Symbol, visit::Dict{Symbol, Bool})
    queue = [source]
    while !isempty(queue)
        current = popfirst!(queue)
        for p in adjList[current]
            if (!visit[p])
                println(p)
                visit[p] = true
                push!(queue, p)
            end
        end
    end
end

function findComponents(adjList::Dict{Symbol, Array{Symbol, 1}})
    visit = Dict(p => false for p in people)

    component = 0
    for p in people
        if (!visit[p] )
            component += 1
            println("Coponent: ", component)
            visit[p] = true
            dfs(adjList, p, visit)
            #bfs(adjList, p, visit)
        end
    end
end

findComponents(adjList)