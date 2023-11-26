// #1647

import Foundation

final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        
        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

        return buffer[index]
    }

    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true

        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }

        return sum * (isPositive ? 1:-1)
    }

    @inline(__always) func readString() -> String {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
    }

    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return Array(buffer[beginIndex..<(index-1)])
    }
}

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

let fIO = FileIO()
let (N, M) = (fIO.readInt(), fIO.readInt())
var graph: [[(Int, Int)]] = Array(repeating: [], count: N+1)

for _ in 1...M {
    let (s, e, c) = (fIO.readInt(), fIO.readInt(), fIO.readInt())
    graph[s].append((e,c))
    graph[e].append((s,c))
}

// DO IT!
solve()

func solve() {
    let mst = prim(1)
    var sum = 0
    
    var maxCostEdge = mst[0].2
    for (_, _, cost) in mst {
        sum += cost
        if cost > maxCostEdge {
            maxCostEdge = cost
        }
    }
    
    sum -= maxCostEdge
    print(sum)
    
}

func prim(_ node: Int) -> [(Int, Int, Int)] {
    var result: [(Int, Int, Int)] = []
    var visited: Set<Int> = [node]
    var queue = MinHeap<Edge>()
    
    for (dest, cost) in graph[node] {
        queue.insert(Edge(node, dest, cost))
    }
    
    while result.count < N - 1 {
        let edge = queue.pop()!
        let (start, end, cost) = (edge.start, edge.end, edge.cost)
        if !visited.contains(end) {
            visited.insert(end)
            result.append((start, end, cost))
            for (newEnd, newCost) in graph[end] {
                queue.insert(Edge(end, newEnd, newCost))
            }
        }
        
    }
    
    return result
}
