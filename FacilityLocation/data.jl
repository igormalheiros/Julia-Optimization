using DelimitedFiles

struct Data
    I::Int
    J::Int
    f::Vector{Int}
    q::Vector{Int}
    Q::Vector{Int}
    c::Matrix{Int}
end

struct Benchmark
    opt_cost::Int
end

function read_input(input_file::String)
    data = split(read(input_file, String))
    I = parse(Int, data[1])
    J = parse(Int, data[2])
    f = [parse(Int, data[i+2]) for i = 1:I]
    q = [parse(Int, data[j+2+I]) for j = 1:J]
    Q = [parse(Int, data[i+2+I+J]) for i = 1:I]
    c = Matrix{Int}(undef, I, J)

    start = 2 + 2 * I + J

    for i = 1:I
        for j = 1:J
            c[i, j] = parse(Int, data[((i-1)*J)+j+start])
        end
    end

    return Data(I, J, f, q, Q, c)
end

function read_output(output_file::String)
    opt_cost = parse(Int, read(output_file, String))
    return Benchmark(opt_cost)
end
