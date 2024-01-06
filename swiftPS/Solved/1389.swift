// #1389
import Foundation

var line = readLine()!.split(separator: " ").map{Int($0)}
var N = line[0]!
var M = line[1]!
var graph: Array<Array<Int>> = Array(repeating: [], count: N+1)
for _ in 1 ... M {
    let line = readLine()!.split(separator: " ").map{Int($0)}
    graph[line[0]!].append(line[1]!)
    graph[line[1]!].append(line[0]!)
}

// DO IT!!
solve()


func solve() {
    var minValue = Int.max
    var minPerson = 1
    
    for start in 1...N {
        var result = 0
        for end in 1...N {
            if (start != end) {
                result += getDistance(start, end)
            }
        }
        if result < minValue {
            minValue = result
            minPerson = start
        }
    }
    
    print(minPerson)
}

func getDistance(_ start: Int, _ end: Int) -> Int {
    var queue: Array<(Int, Int)> = [(start, 0)]
    var visited: Set<Int> = []
    
    while !queue.isEmpty {
        let q = queue.removeFirst()
        if (q.0 == end) {
            return q.1
        }
        let nq = q.1 + 1
        for adj in graph[q.0] {
            if (!visited.contains(adj)) {
                queue.append((adj,nq))
                visited.insert(adj)
            }
        }
    }
    return -1;
}
