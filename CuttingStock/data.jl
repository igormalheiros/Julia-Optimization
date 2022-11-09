using DelimitedFiles

struct Data
    L::Int
    n::Int
    m::Int
    l::Vector{Float64}
    b::Vector{Int}
end

struct Benchmark
    opt_cost::Int
end

function read_input(input_file::String)
    data = split(read(input_file, String))
    L = parse(Int, data[1])
    n = parse(Int, data[2])
    m = parse(Int, data[3])
    l = [parse(Float64, data[i+3]) for i = 1:m]
    b = [parse(Int, data[i+3+m]) for i = 1:m]
    return Data(L, n, m, l, b)
end

function read_output(output_file::String)
    opt_cost = parse(Int, read(output_file, String))
    return Benchmark(opt_cost)
end
