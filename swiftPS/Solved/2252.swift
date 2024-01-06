// #2252

import Foundation

let line = readLine()!.split(separator: " ").map {Int($0)!}
let (N, M) = (line[0], line[1])
var graph: [[Int]] = Array(repeating: [], count: N+1)
var indegree: [Int] = Array(repeating: 0, count: N+1)

for _ in 1...M {
    let line = readLine()!.split(separator: " ").map {Int($0)!}
    graph[line[0]].append(line[1])
    indegree[line[1]] += 1
}

// DO IT!
solve()

func solve() {
    var result: [Int] = []
    var queue: [Int] = []
    
    for index in 1...N {
        if indegree[index] == 0 {
            queue.append(index)
        }
    }
    
    while result.count < N {
        let q = queue.removeLast()
        
        result.append(q)
        
        for adj in graph[q] {
            indegree[adj] -= 1
            if indegree[adj] == 0 {
                queue.append(adj)
            }
        }
    }
    
    for r in result {
        print(r, terminator: " ")
    }
    print()
}
