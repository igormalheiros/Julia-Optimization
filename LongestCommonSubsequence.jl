# ====== Code by Igor Malheiros - July of 2019 ====== #
# ====== Longest Common Subsequence ====== #
# ====== Using Brute Force and Dynamic Programming approaches ====== #

function solve_brute_force(string1::String, string2::String, i::Int, j::Int)
    if ( i == 0 || j == 0 ) return 0 end

    if ( string1[i] == string2[j] )
        return 1 + solve_brute_force(string1, string2, i-1, j-1)
    else
        return max( solve_brute_force(string1, string2, i-1, j), 
                    solve_brute_force(string1, string2, i, j-1) )
    end

    return
end

function solve_dp(string1::String, string2::String)
    n = length(string1)+1
    m = length(string2)+1
    memo = zeros(n, m)

    for i in 2:n
        for j in 2:m

            if (string1[i-1] == string2[j-1])
                memo[i,j] = 1 + memo[i-1, j-1]
            else
                memo[i,j] = max(memo[i-1, j], memo[i, j-1])
            end

        end
    end

    return memo[n, m]
end

string1 = "AGGTAB"
string2 = "GXTXAYB"

println("First String: ", string1)
println("Second String: ", string2, "\n")
println("Brute Force Approache:")
println("The Longest Common Subsequence has value: ", solve_brute_force(string1, string2, length(string1), length(string2) ) )
println("\nDynamic Programming:")
println("The Longest Common Subsequence has value: ", solve_dp(string1, string2) )