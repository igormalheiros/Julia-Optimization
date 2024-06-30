include("data.jl")
include("model.jl")

using Printf

function run()
    # Test 1
    data_1 = read_input("input/a2-16.in")
    benchmark_1 = read_output("output/a2-16.out")

    @time solution_1 = solve(data_1)
    @test isapprox(solution_1.obj, benchmark_1.opt_cost, atol=1e-2)

    print_solution(data_1, solution_1)
end

function print_solution(data::Data, solution::Solution)
    println("******** Printing Solution! ********\n")
    K = 1:data.v
    e = data.e
    l = data.l
    C = data.C

    for k in K
        println("Vehicle: ", k)
        route = solution.routes[k]
        for (i, id) in enumerate(route.sequence)
            @printf("Visiting node: %d at %.2f [%.2f, %.2f] | total capacity: %d/%d\n", id,  e[id], route.arrivals[i], l[id], route.demands[i], C)
        end
        println("")
    end

    @printf("Obj Function: %.2f\n", solution.obj)
    println("******** End of Printing! ********\n")
    return
end

run()