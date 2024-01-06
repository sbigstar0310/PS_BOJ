// #9465

import Foundation

let T = Int(readLine()!)!
var result: [Int] = []

for _ in 1...T {
    let N = Int(readLine()!)!
    let up: [Int] = readLine()!.split(separator: " ").map {Int($0)!}
    let down: [Int] = readLine()!.split(separator: " ").map {Int($0)!}
    var dpUp: [Int] = Array(repeating: 0, count: N)
    var dpDown: [Int] = Array(repeating: 0, count: N)
    
    
    // DO IT!
    solve()
    
    func solve() {
        for index in 0..<N {
            if index == 0 {
                dpUp[index] = up[index]
                dpDown[index] = down[index]
            } else if index == 1 {
                dpUp[index] = dpDown[index-1] + up[index]
                dpDown[index] = dpUp[index-1] + down[index]
            } else {
                dpUp[index] = max(dpDown[index-1] + up[index], max(dpUp[index-2], dpDown[index-2]) + up[index])
                dpDown[index] = max(dpUp[index-1] + down[index], max(dpUp[index-2], dpDown[index-2]) + down[index])
            }
        }
        
        result.append(max(dpUp[N-1], dpDown[N-1]))
    }
}

for r in result {
    print(r)
}
