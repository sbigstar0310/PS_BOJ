// #2096

import Foundation

let N = Int(readLine()!)!
var table: [[Int]] = []
for _ in 1...N {
    let line = readLine()!.split(separator: " ").map {Int($0)!}
    table.append([line[0], line[1], line[2]])
}

// DO IT!
solve()

func solve() {
    let max = getF() { $0 > $1 ? $0 : $1}
    let min = getF() { $0 < $1 ? $0 : $1}
    print("\(max) \(min)")
}

func getF(_ f: (Int, Int) -> Int) -> Int {
    var dp = table[0]
    for index in 1..<N {
        var newDp = [0,0,0]
        newDp[0] = f(table[index][0] + dp[0], table[index][0] + dp[1])
        newDp[1] = f(f(table[index][1] + dp[0], table[index][1] + dp[1]), table[index][1] + dp[2])
        newDp[2] = f(table[index][2] + dp[1], table[index][2] + dp[2])
        dp = newDp
    }
    return f(f(dp[0], dp[1]), dp[2])
}

