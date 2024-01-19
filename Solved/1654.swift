// #1654

import Foundation

let line = readLine()!.split(separator: " ").map {Int($0)!}
let (K, N) = (line[0], line[1])
var lan = [Int](repeating: 0, count: K)
for index in 0..<K {
    let length = Int(readLine()!)!
    lan[index] = length
}

// DO IT!
solve()

func solve() {
    var min: CLong = 1
    var max: CLong = lan.max()!
    var current: CLong = 0
    var count: CLong  = 0
    var resultArr: [CLong] = []
    
    while min <= max {
        current = (min + max) / 2
        count = 0
        for l in lan {
            count += (l / current)
        }
        if count >= N {
            resultArr.append(current)
            min = current + 1
        } else {
            max = current - 1
        }
    }
    
    print(resultArr.max()!)
}
