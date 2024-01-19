// #11866

import Foundation

let line = readLine()!.split(separator: " ").map {Int($0)!}
var (N, K) = (line[0], line[1])

// DO IT!
solve()

func solve() {
    var nums: [Int] = Array(1...N)
    var index = K - 1
    var result = [Int]()
    
    while !nums.isEmpty {
        let q = nums.remove(at: index)
        result.append(q)
        if nums.isEmpty {
            break
        }
        index += K - 1
        index = (index >= nums.count) ? index % nums.count : index
    }
    
    print("<" + result.map {String($0)}.joined(separator: ", ") + ">")
}
