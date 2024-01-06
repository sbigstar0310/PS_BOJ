// 1932

import Foundation

let N = Int(readLine()!)!
var triangle: [[Int]] = []

for _ in 1...N {
    let line = readLine()!.split(separator: " ").map {Int($0)!}
    triangle.append(line)
}

// DO IT!
solve()

func solve() {
    var result: [Int] = []
    let first = triangle.removeFirst()
    result.append(first.first!)
    
    while !triangle.isEmpty {
        let q = triangle.removeFirst()
        result = stack(result, q)
    }
    
    print(result.max()!)
}

func stack(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
    var result: [Int] = []
    var newArr1 = [0] + arr1 + [0]
    for index in 0..<arr2.count {
        result.append((arr2[index] + max(newArr1[index], newArr1[index + 1])))
    }
    return result
}
