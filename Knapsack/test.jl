include("data.jl")
include("model.jl")

function run()
    # Test 1
    data_1 = read_input("input/input1.in")
    benchmark_1 = read_output("output/output1.out")

    @time solution_1 = solve(data_1)
    @test solution_1.obj == benchmark_1.opt_cost

    print_solution(data_1, solution_1)

    # Test 2
    data_2 = read_input("input/input2.in")
    benchmark_2 = read_output("output/output2.out")
    println(data_2)

    solution_2 = solve(data_2)
    @test solution_2.obj == benchmark_2.opt_cost

    print_solution(data_2, solution_2)
end

function print_solution(data::Data, solution::Solution)
    println("******** Printing Solution! ********\n")
    n = data.n
    W = data.W
    v = data.v
    w = data.w
    load = 0

    for i = 1:n
        if solution.x[i]
            println("Item ", i, " with weight ", w[i], " and with value ", v[i])
            load += w[i]
        end
    end

    println("Load: ", load, "/", W)

    println("Obj Function: ", solution.obj)
    println("******** End of Printing! ********\n")
    return
end

run()
