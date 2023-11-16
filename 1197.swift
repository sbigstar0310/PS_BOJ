// #1197
import Foundation

struct MinHeap<Element: Comparable> {
    var elements: [Element] = []

    var isEmpty: Bool {
        return elements.isEmpty
    }

    var count: Int {
        return elements.count
    }

    mutating func insert(_ element: Element) {
        elements.append(element)
        siftUp(from: elements.count - 1)
    }

    mutating func siftUp(from index: Int) {
        var child = index
        var parent = parentIndex(of: child)

        while child > 0 && elements[child] < elements[parent] {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(of: child)
        }
    }

    mutating func pop() -> Element? {
        guard !isEmpty else {
            return nil
        }

        elements.swapAt(0, count - 1)
        let element = elements.removeLast()
        siftDown(from: 0)
        return element
    }

    mutating func siftDown(from index: Int) {
        var parent = index

        while true {
            let leftChild = leftChildIndex(of: parent)
            let rightChild = rightChildIndex(of: parent)
            var candidate = parent

            if leftChild < count && elements[leftChild] < elements[candidate] {
                candidate = leftChild
            }

            if rightChild < count && elements[rightChild] < elements[candidate] {
                candidate = rightChild
            }

            if candidate == parent {
                return
            }

            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }

    func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }

    func leftChildIndex(of index: Int) -> Int {
        return index * 2 + 1
    }

    func rightChildIndex(of index: Int) -> Int {
        return index * 2 + 2
    }
}

struct Edge: Comparable {
    var start: Int
    var end: Int
    var cost: Int
    
    init(_ start: Int, _ end: Int, _ cost: Int) {
        self.start = start
        self.end = end
        self.cost = cost
    }
    
    static func < (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.cost < rhs.cost
    }
}

let line = readLine()!.split(separator: " ").map {Int($0)!}
let (V, E) = (line[0], line[1])
var graph: [[(Int, Int)]] = Array(repeating: [], count: V+1                   )

for _ in 1...E {
    let line = readLine()!.split(separator: " ").map {Int($0)!}
    graph[line[0]].append((line[1], line[2]))
    graph[line[1]].append((line[0], line[2]))
}

// DO IT
solve()

func solve() {
    // Using "Prim algorithm"
    let startNode = 1
    let result = prim(startNode)
    print(result)
}

func prim(_ node: Int) -> Int {
    var connected: Set<Int> = [node]
    var edgeList: MinHeap<Edge> = MinHeap()
    var result: [Int] = []
    
    for (end, cost) in graph[node] {
        edgeList.insert(Edge(node, end, cost))
    }
    
    while connected.count != V {
        guard let edge = edgeList.pop() else { break }

        let (_, endNode, cost) = (edge.start, edge.end, edge.cost)
        if connected.contains(endNode) {
            continue
        }
        connected.insert(endNode)
        result.append(cost)
        for (end, cost) in graph[endNode] {
            edgeList.insert(Edge(endNode, end, cost))
        }
        
    }
    return result.reduce(0) {$0 + $1}
}
