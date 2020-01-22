# ====== Code by Igor Malheiros - January of 2020 ====== #
# ====== Assignment Problem using Integer Programming ====== #

using JuMP, GLPK
import MathOptInterface # Replaces MathProgBase
const MOI = MathOptInterface

# ------ Data ------

#Cost matrix c
c = [995 756 1092 951 964 1171 1194 1113 1104 1276 1089 382 517 28 1025 1240 969 841 981 934;
     1056 993 1038 1049 1044 1230 1239 1143 954 1222 942 1252 955 1042 944 664 1046 715 924 1044;
     1192 938 894 1285 1149 1227 893 1179 916 1234 953 975 1093 1070 783 987 1247 1054 1323 1069;
     951 1049 2085 932 1387 1478 985 1248 1102 753 1053 935 936 963 826 1185 1691 640 1164 970;
     864 1044 1249 1387 981 1123 953 1253 953 862 1285 1296 974 935 1070 1041 185 847 1056 530] 

#Capacity of each facility
Q = [1324, 1975, 1506, 1938, 2010]

#Demand of each client
q = [716, 181, 182, 567, 125, 330, 153, 234, 117, 510, 928, 541, 148, 291, 360, 434, 148, 560, 321, 583]

#Fixed cost of each facility
f = [50201, 44208, 58800, 51130, 4940]


function solve(c::Array{Int, 2}, Q::Array{Int, 1}, q::Array{Int, 1}, f::Array{Int, 1})
    println("Solving Facility Location...")

    I = length(Q)
    J = length(q)

    model = Model(with_optimizer(GLPK.Optimizer))

    @variable(model, y[1:I], Bin)
    @variable(model, 0 <= x[1:I, 1:J] <= 1)

    @objective(model, Min, (sum( f[i] * y[i] for i in 1:I) + sum( c[i, j] * x[i, j] for i in 1:I, j in 1:J) ) )

    for j in 1:J
        @constraint(model, sum(x[i, j] for i in 1:I) == 1)
    end

    for i in 1:I
        @constraint(model, sum(q[j] * x[i, j] for j in 1:J) <= (Q[i] * y[i]) )
    end

    JuMP.optimize!(model)

    for i in 1:I
        if (value(y[i]) == 1.0)
            println("Facility ", i, " is open!")
        end
    end

    println("")

    for i in 1:I
        for j in 1:J
            if (value(x[i,j]) > 0.0)
                println("Client ", j, " is assigned to facility ", i, " with value: ", value(x[i,j]))
            end
        end
    end

    println("\nTotal value: ", JuMP.objective_value(model), "\n\n")

    @show JuMP.has_values(model)
    @show JuMP.termination_status(model) == MOI.OPTIMAL
    @show JuMP.primal_status(model) == MOI.FEASIBLE_POINT

    @show JuMP.objective_value(model)

    return

end

@time solve(c, Q, q, f)