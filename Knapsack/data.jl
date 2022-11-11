using DelimitedFiles

struct Data
    n::Int
    W::Int
    v::Vector{Int}
    w::Vector{Int}
end

struct Benchmark
    opt_cost::Int
end

function read_input(input_file::String)
    data = split(read(input_file, String))
    n = parse(Int, data[1])
    W = parse(Int, data[2])
    v = [parse(Int, data[i+2]) for i = 1:n]
    w = [parse(Int, data[i+2+n]) for i = 1:n]

    return Data(n, W, v, w)
end

function read_output(output_file::String)
    opt_cost = parse(Int, read(output_file, String))
    return Benchmark(opt_cost)
end
