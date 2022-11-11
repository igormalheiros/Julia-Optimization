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

    @time solution_2 = solve(data_2)
    @test solution_2.obj == benchmark_2.opt_cost

    print_solution(data_2, solution_2)
end

function print_solution(data::Data, solution::Solution)
    println("******** Printing Solution! ********\n")
    I = data.I
    J = data.J
    f = data.f
    q = data.q
    Q = data.Q
    c = data.c

    for i = 1:I
        if solution.y[i]
            println("Facility ", i, " with cost: ", f[i], " is open!")
            total_demand = 0
            total_cost = f[i]
            for j = 1:J
                if solution.x[i, j]
                    total_demand += q[j]
                    println(
                        "Client ",
                        j,
                        " with demand: ",
                        q[j],
                        " is assigned to facility ",
                        i,
                        " with cost: ",
                        c[i, j],
                    )
                    total_cost += c[i, j]
                end
            end
            println("Total demand: ", total_demand, "/", Q[i])
            println("Total cost: ", total_cost)
        end
    end
    println("Obj Function: ", solution.obj)
    println("******** End of Printing! ********\n")
    return
end

run()
