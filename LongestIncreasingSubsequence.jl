# ====== Code by Igor Malheiros - August of 2019 ====== #
# ====== Longest Increasing Subsequence ====== #
# ====== Using Brute Force and Dynamic Programming approaches ====== #

function solve_brute_force(arr::Array{Int}, ind::Int, curr::Int)
    if ( ind > length(arr) )
        return 1
    elseif (arr[ind] >= curr)
        return 1 + solve_brute_force(arr, ind+1, arr[ind])
    else
        return max( solve_brute_force(arr, ind+1, curr), 
                    solve_brute_force(arr, ind+1, arr[ind]) )
    end
    return 0
end

# Method with O(n) space and O(nˆ2) time
function solve_dp(arr::Array{Int})
    len = length(arr)
    memo = ones(len)

    for i in 2:len
        for j in 1:i
            if (arr[j] < arr[i] )
                memo[i] = max(memo[i], memo[j]+1)
            end
        end    
    end
    return memo[len]
end


arr = [10, 22, 9, 33, 21, 50, 41, 60, 80]
# arr = [3, 10, 2, 1, 20]
# arr = [3, 2]

println("Array: ", arr)
println("Brute Force Approache:")
println("The Longest Increasing Subsequence has size: ", solve_brute_force(arr, 2, arr[1]) )
println("\nDynamic Programming:")
println("The Longest Increasing Subsequence has size: ", solve_dp(arr) )