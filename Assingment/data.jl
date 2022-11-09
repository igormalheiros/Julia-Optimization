using DelimitedFiles

struct Data
    n::Int
    c::Matrix{Int}
end

struct Benchmark
    opt_cost::Int
end

function read_input(input_file::String)
    data, header = readdlm(input_file, ' ', Int; header = true)
    n = parse(Int, header[1])
    return Data(n, data)
end

function read_output(output_file::String)
    opt_cost = parse(Int64, read(output_file, String))
    return Benchmark(opt_cost)
end
