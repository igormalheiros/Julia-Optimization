# ====== Code by Igor Malheiros - March of 2020 ====== #
# ====== Longest Increasing Subsequence ====== #
# ====== Using Dynamic Programming and Divide and Conquer approaches ====== #


# Method with O(n) space and O(nˆ2) time
function solve_dp(arr::Array{Int})
    len = length(arr)
    memo = ones(len)
    lis = 0

    for i in 2:len
        for j in 1:i
            if (arr[j] < arr[i] )
                memo[i] = max(memo[i], memo[j]+1)
                lis = max(lis, memo[i])
            end
        end    
    end
    return lis
end

# Method with O(n) space and O(n log k) time, where k is the size of LIS
function solve_dc(arr::Array{Int})
    len = length(arr)
    memo = []
    lis = 0

    for i in 1:len
        pos = searchsortedfirst(memo, arr[i])
        if (pos > length(memo) )
            push!(memo, arr[i])
        else
            memo[pos] = arr[i]
        end

        if (pos > lis)
            lis = pos
        end

    end
    return lis
end

# arr = [10, 22, 9, 33, 21, 50, 41, 60, 80]
# arr = [7, 10, 9, 2, 3, 8, 1]
# arr = [2, 5, 3, 45, 67]
arr = [5, 7, 6, 4, 12, 8, 9, 10]
# arr = [3, 10, 2, 1, 20]

println("Array: ", arr)
println("\nDynamic Programming:")
println("The Longest Increasing Subsequence has size: ", solve_dp(arr) )
println("\nDivide and Conquer:")
println("The Longest Increasing Subsequence has size: ", solve_dc(arr) )