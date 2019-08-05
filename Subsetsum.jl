# ====== Code by Igor Malheiros - June of 2019 ====== #
# ====== Subsetsum using Brute Force and Dynamic Programming approaches ====== #


function solve_brute_force(set::Array{Int}, indx::Int, sum::Int)
    if (sum == 0) return true end
    if (indx > length(set) ) return false end
    if ( (sum - set[indx]) < 0) return solve_brute_force(set, indx+1, sum) end
    return solve_brute_force(set, indx+1, sum-set[indx]) || solve_brute_force(set, indx+1, sum)
end

function solve_dp(set::Array{Int}, sum::Int)
    n = length(set)
    memo = falses(n+1, sum+1)

    for i in 1:n+1
        memo[i, 1] = true
    end

    for i in 1:n
        for j in 1:sum
            if (j < set[i]) memo[i+1, j+1] = memo[i, j+1]
            else memo[i+1, j+1] = memo[i, j+1] || memo[i, j+1-set[i]] end
        end
    end

    return memo[n+1, sum+1]
end

set = [3, 34, 4, 12, 5, 2]
sum = 9

println("Set:", set, " ---- Sum: ", sum)
println("\nBrute Force:")
if ( solve_brute_force(set, 1, sum) ) println("True")
else println("False") end
println("\nDynamic Programming:")
if ( solve_dp(set, sum) ) println("True")
else println("False") end

#for sum in 1:50
#    if (solveBruteForce(set, 1, sum) == solveDP(set, sum)) println("Right! for test with sum = ", sum)
#    else println("Wrong for test with sum = ", sum) end
#end