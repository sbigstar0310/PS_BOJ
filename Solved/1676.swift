// 1676

import Foundation

let N = Int(readLine()!)!
var memo: [Int: Int] = [:]

//DO IT!
solve()

func solve() {
    
    let result: (Int, Int) = countZero(N)
    print(min(result.0, result.1))
    
}

func countZero(_ N: Int) -> (Int, Int) {
    if N == 1 || N == 0 {
        return (0, 0)
    } else {
        let twoCount = divideBy(N, 2)
        let fiveCount = divideBy(N, 5)
        return add((twoCount, fiveCount), countZero(N - 1))
    }
}

func divideBy(_ N: Int, _ t: Int) -> Int {
    var result = 0
    var nN = N
    while true {
        if nN % t == 0 {
            nN /= t
            result += 1
        } else {
            break
        }
    }
    return result
}

func add(_ t1: (Int, Int), _ t2: (Int, Int)) -> (Int, Int) {
    return (t1.0 + t2.0, t1.1 + t2.1)
}
