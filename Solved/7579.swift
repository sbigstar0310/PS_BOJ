// #7579

import Foundation

let line = readLine()!.split(separator: " ").map {Int($0)!}
var (N, M) = (line[0], line[1])
var memoryAndCost: [(Int, Int)] = [(0,0)]
let memLine = readLine()!.split(separator: " ").map {Int($0)!}
let costLine = readLine()!.split(separator: " ").map {Int($0)!}
var dp: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: 100 * 100 + 1), count: 101)

for index in 0..<N {
    let cost = costLine[index]
    let mem = memLine[index]
    memoryAndCost.append((mem, cost))
}

//DO IT!
solve()

func solve() {
    for step in 1...N {
        for cost in 0...10000 {
            let eleMem = memoryAndCost[step].0
            let eleCost = memoryAndCost[step].1
            
            if cost < eleCost {
                dp[step][cost] = dp[step - 1][cost]
            } else {
                dp[step][cost] = max(dp[step - 1][cost], dp[step - 1][cost - eleCost] + eleMem)
            }
        }
    }
    
    for cost in 0...10000 {
        if (dp[N][cost] >= M) {
            print(cost)
            break
        }
    }
}




