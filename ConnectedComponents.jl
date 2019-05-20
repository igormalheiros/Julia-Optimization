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

function dfs(adjList, source, visit)
    println(source)
    for p in adjList[source]
        if(visit[p] == 0)
            visit[p] = 1
            dfs(adjList, p, visit)
        end
    end
end

function bfs(adjList, source, visit)
    queue = [source]
    while !isempty(queue)
        current = popfirst!(queue)
        for p in adjList[current]
            if visit[p] == 0
                println(p)
                visit[p] = 1
                push!(queue, p)
            end
        end
    end
end

function findComponents(adjList)
    visit = Dict(p => 0 for p in people)
    component = 0
    for p in people
        if(visit[p] == 0)
            component += 1
            println("Coponent: ", component)
            visit[p] = 1
            #dfs(adjList, p, visit)
            bfs(adjList, p, visit)
        end
    end
end

findComponents(adjList)