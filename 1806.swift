// #1806

import Foundation

let line = readLine()!.split(separator: " ").map {Int($0)!}
let (N, S) = (line[0], line[1])
var numArr: [Int] = readLine()!.split(separator: " ").map {Int($0)!} + [0]

// DO IT!
solve()

func solve() {
    var minLen = Int.max
    var sum = 0
    var s = 0
    var e = 0
    
    while (s < N && e <= N) {
        let len = e - s
        if sum >= S {
            sum -= numArr[s]
            s += 1
            minLen = len < minLen ? len : minLen
        } else {
            sum += numArr[e]
            e += 1
        }
    }
    
    print(minLen == Int.max ? 0 : minLen)
}

