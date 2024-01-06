// #2342

import Foundation
typealias Foot = (Int, Int)
let order = readLine()!.split(separator: " ").map {Int($0)!}
let N = order.count - 1
var dp: [[[Int]]] = Array(repeating: Array(repeating: Array(repeating: 400001, count: 5), count: 5), count: N)


// DO IT!
solve()

func solve() {
    var minCost = Int.max
    
    if N == 0 {
        print(0)
        return
    }
    
    for step in 0..<N {
        if step == 0 {
            dp[0][order[0]][0] = 2
            dp[0][0][order[0]] = 2
            continue
        }
        
        let nxt = order[step]
        for left in 0...4 {
            for right in 0...4 {
                let leftCost = getFootChangeCost(left, nxt)
                let rightCost = getFootChangeCost(right, nxt)
                if nxt != right {
                    dp[step][nxt][right] = min(dp[step][nxt][right], dp[step-1][left][right] + leftCost)
                }
                if nxt != left {
                    dp[step][left][nxt] = min(dp[step][left][nxt], dp[step-1][left][right] + rightCost)
                }
            }
        }
    }
    
    for left in 0...4 {
        for right in 0...4 {
            let cost = dp[N-1][left][right]
            if cost < minCost {
                minCost = cost
            }
        }
    }
    
    print(minCost)
}

func getFootChangeCost(_ now: Int, _ to: Int) -> Int {
    if now == 0 {
        return 2
    } else if now == to {
        return 1
    } else if abs(now - to) == 1 || abs(now - to) == 3 {
        return 3
    } else {
        return 4
    }
}
