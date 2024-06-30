using DelimitedFiles

struct Data
    n::Int
    v::Int
    C::Int
    T::Float64
    L::Float64
    e::Vector{Float64}
    l::Vector{Float64}
    s::Vector{Float64}
    q::Vector{Int}
    t::Matrix{Float64}
    c::Matrix{Float64}
end

struct Benchmark
    opt_cost::Float64
end

function euclidean_distance(x1::Float64, y1::Float64, x2::Float64, y2::Float64)
    return sqrt((x1 - x2)^2 + (y1 - y2)^2)
end

function read_input(input_file::String)
    data = split(read(input_file, String))
    v = parse(Int, data[1])
    n = parse(Int, data[2])
    T = parse(Float64, data[3])
    C = parse(Int, data[4])
    L = parse(Float64, data[5])
    e = [0.0 for _ = 1:(2*(n+1))]
    l = [0.0 for _ = 1:(2*(n+1))]
    q = [0 for _ = 1:(2*(n+1))]
    s = [0.0 for _ = 1:(2*(n+1))]
    xs = [0.0 for _ = 1:(2*(n+1))]
    ys = [0.0 for _ = 1:(2*(n+1))]

    # Depot 0
    idx = 6
    xs[(2*n) + 1] = parse(Float64, data[idx + 1])
    ys[(2*n) + 1] = parse(Float64, data[idx + 2])
    s[(2*n) + 1] = parse(Float64, data[idx + 3])
    q[(2*n) + 1] = parse(Int, data[idx + 4])
    e[(2*n) + 1] = parse(Float64, data[idx + 5])
    l[(2*n) + 1] = parse(Float64, data[idx + 6])
    idx += 7

    for i = 1:(2*n)
        xs[i] = parse(Float64, data[idx + 1])
        ys[i] = parse(Float64, data[idx + 2])
        s[i] = parse(Float64, data[idx + 3])
        
        q[i] = parse(Int, data[idx + 4])
        e[i] = parse(Float64, data[idx + 5])
        l[i] = parse(Float64, data[idx + 6])
        idx += 7
    end

    # Depot ending
    xs[2*(n + 1)] = parse(Float64, data[idx + 1])
    ys[2*(n + 1)] = parse(Float64, data[idx + 2])
    s[2*(n + 1)] = parse(Float64, data[idx + 3])
    q[2*(n + 1)] = parse(Int, data[idx + 4])
    e[2*(n + 1)] = parse(Float64, data[idx + 5])
    l[2*(n + 1)] = parse(Float64, data[idx + 6])

    c = [euclidean_distance(xs[i], ys[i], xs[j], ys[j]) for i = 1:(2*(n+1)), j = 1:(2*(n+1))]
    t = [euclidean_distance(xs[i], ys[i], xs[j], ys[j]) for i = 1:(2*(n+1)), j = 1:(2*(n+1))]

    return Data(n, v, C, T, L, e, l, s, q, t, c)
end

function read_output(output_file::String)
    opt_cost = parse(Float64, read(output_file, String))
    return Benchmark(opt_cost)
end