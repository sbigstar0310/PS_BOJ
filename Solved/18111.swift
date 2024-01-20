//18111

import Foundation

let line = readLine()!.split(separator: " ").map {Int($0)!}
let (N, M, B) = (line[0], line[1], line[2])
var ground: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

for n in 0..<N {
    let line = readLine()!.split(separator: " ").map {Int($0)!}
    ground[n] = line
}


// DO IT!
solve()

func solve() {
    var result: [(time: Int, height: Int)] = []
    
    for height in 0...256 {
        let time = getTimeFor(height: height, inventory: B)
        result.append((time, height))
    }
    
    result.sort { r1, r2 in
        if r1.time == r2.time {
            return r1.height > r2.height
        } else {
            return r1.time < r2.time
        }
    }
    
    print("\(result[0].time) \(result[0].height)")
}

func getTimeFor(height h: Int, inventory i: Int) -> Int {
    var resultTime = 0
    var usedBlock = i
    
    for n in 0..<N {
        for m in 0..<M {
            if ground[n][m] <= h {
                let diff = h - ground[n][m]
                resultTime += diff
                usedBlock -= diff
            } else {
                let diff = ground[n][m] - h
                resultTime += diff * 2
                usedBlock += diff
            }
        }
    }
    
    if usedBlock < 0 {
        return Int.max
    }
    return resultTime
}
