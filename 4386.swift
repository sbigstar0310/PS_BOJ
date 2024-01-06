// #4386

import Foundation

typealias Point = (x: Double, y: Double)
typealias Edge = (s: Int, e: Int)

let N  = Int(readLine()!)!
var points: [Point] = []
var distance: [[Double]] = Array(repeating: Array(repeating: 0.0, count: N), count: N)

for _ in 1...N {
    let line = readLine()!.split(separator: " ").map {Double($0)!}
    points.append((line[0], line[1]))
}

//DO IT
solve()

func solve() {
    getDistanceArr()
    
    //프림 알고리즘 사용
    var result = 0.0
    var visited: Set<Int> = [0]
    var queue: [(Edge, Double)] = []
    for (index, len) in distance[0].enumerated() where !visited.contains(index) {
        queue.append(((0, index), len))
    }
            
    while visited.count < N {
        let (minEdge, minLen) = popMinNode(&queue, visited)
        visited.insert(minEdge.e)
        result += minLen
        
        for (index, len) in distance[minEdge.e].enumerated() where !visited.contains(index) {
            queue.append(((minEdge.e, index), len))
        }
    }
    
    print(result)
}

func popMinNode( _ arr : inout [(Edge, Double)], _ visited: Set<Int>) -> (Edge, Double) {
    var min = 1001.0
    var minEdge: Edge = (0,0)
    var minIndex = 0
    
    for (index, (edge, cost)) in arr.enumerated() {
        if cost < min && !(visited.contains(edge.s) && visited.contains(edge.e)){
            min = cost
            minEdge = edge
            minIndex = index
        }
    }
    
    arr.remove(at: minIndex)
    return (minEdge, min)
}

func getDistanceArr() {
    for (index1, point1) in points.enumerated() {
        for (index2, point2) in points.enumerated() {
            let dis = getDistance(point1: point1, point2: point2)
            distance[index1][index2] = dis
            distance[index2][index1] = dis
        }
    }
}

func getDistance(point1 p1: Point, point2 p2: Point) -> Double {
    var dis = 0.0
    dis = sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2))
    return dis
}
