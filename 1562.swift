// #1562

import Foundation

let N = Int(readLine()!)!
var dp: [[[Int]]] = Array(repeating: Array(repeating: Array(repeating: 0, count: 1024), count: 10), count: N)
let mod = 1000000000

// DO IT!
solve()

func solve() {
    var resultCnt = 0
    
    for num in 1...9 {
        dp[0][num][0 | 1 << num] = 1
    }
    
    for index in 0..<(N-1) {
        for endNum in 0...9 {
            for bit in 0..<1024 {
                if endNum == 0 {
                    dp[index + 1][1][bit | (1 << 1)] += dp[index][0][bit]
                    dp[index + 1][1][bit | (1 << 1)] %= mod
                } else if endNum == 9 {
                    dp[index + 1][8][bit | (1 << 8)] += dp[index][9][bit]
                    dp[index + 1][8][bit | (1 << 8)] %= mod
                } else {
                    dp[index + 1][endNum - 1][bit | (1 << (endNum - 1))] += dp[index][endNum][bit]
                    dp[index + 1][endNum + 1][bit | (1 << (endNum + 1))] += dp[index][endNum][bit]
                    dp[index + 1][endNum - 1][bit | (1 << (endNum - 1))] %= mod
                    dp[index + 1][endNum + 1][bit | (1 << (endNum + 1))] %= mod
                }
                
            }
        }
    }
    
    for endNum in 0..<10 {
        resultCnt += dp[N - 1][endNum][1023]
        resultCnt %= mod
    }
    
    print(resultCnt)
}
