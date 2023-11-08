// #1967

import Foundation
let N  = Int(readLine()!)!
var graph: [[(Int, Int)]] = Array(repeating: [], count: N+1)

for _ in 0..<(N-1) {
    let line = readLine()!.split(separator: " ").map {Int($0)!}
    graph[line[0]].append((line[1], line[2]))
    graph[line[1]].append((line[0], line[2]))
}

// DO IT!
solve()


func solve() {
    if N == 1 {
        print(0)
    } else {
        let dist1 = dijstra(1)
        let maxIndex1 = findMaxIndex(dist1)
        let dist2 = dijstra(maxIndex1)
        let maxIndex2 = findMaxIndex(dist2)
        print(dist2[maxIndex2])
    }
}

func dijstra(_ start: Int) -> [Int] {
    var dist = Array(repeating: Int.max, count: N+1)
    var unvisited = Array(1...N)
    
    dist[start] = 0
    
    while !unvisited.isEmpty {
        let q = popMinNode(dist, unvisited)
        unvisited.remove(at: unvisited.firstIndex(of: q)!)
        
        for (end, cost) in graph[q] {
            let newDist = dist[q] + cost
            if newDist < dist[end] {
                dist[end] = newDist
            }
        }
    }
    
    return dist
}

func popMinNode(_ dist: [Int], _ unvisited: [Int]) -> Int {
    var minNode = -1
    var minValue = Int.max
    
    for node in unvisited {
        if dist[node] < minValue {
            minNode = node
            minValue = dist[node]
        }
    }
    
    return minNode
}

func findMaxIndex(_ arr: [Int]) -> Int {
    var max = 0
    var maxIndex = 0
    
    for index in 1..<arr.count {
        if max <= arr[index] {
            max = arr[index]
            maxIndex = index
        }
    }
    
    return maxIndex
}
