// #2623

import Foundation

let line = readLine()!.split(separator: " ").map {Int($0)!}
let (N, M) = (line[0], line[1])

var graph: [[Int]] = Array(repeating: [], count: N+1)
var indegree: [Int] = [Int](repeating: 0, count: N+1)

for _ in 1...M {
    var line = readLine()!.split(separator: " ").map {Int($0)!}
    var lineLen = line.removeFirst()
    for index in 0..<(lineLen-1) {
        let start = line[index]
        let end = line[index + 1]
        graph[start].append(end)
        indegree[end] += 1
    }
}

// DO IT!
solve()

func solve() {
    // 위상정렬
    var result: [Int] = []
    var queue: [Int] = []
    for (index, degree) in indegree.enumerated() {
        if degree == 0 && index != 0 {
            queue.append(index)
        }
    }
    
    while !queue.isEmpty {
        let q = queue.removeLast()
        result.append(q)
        
        for adj in graph[q] {
            indegree[adj] -= 1
            if indegree[adj] == 0 {
                queue.append(adj)
            }
        }
    }
    
    if result.count != N {
        print(0)
    } else {
        for r in result {
            print(r)
        }
    }
}
