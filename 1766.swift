// #1766

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

let line = readLine()!.split(separator: " ").map {Int($0)!}
let (N, M) = (line[0], line[1])
var graph: [[Int]] = Array(repeating: [], count: N+1)
var inDegree = Array(repeating: 0, count: N+1)

for _ in 1...M {
    let line = readLine()!.split(separator: " ").map {Int($0)!}
    graph[line[0]].append(line[1])
    inDegree[line[1]] += 1
}

// DO IT!
solve()

func solve() {
    var result: [Int] = []
    var queue = MinHeap<Int>()
    
    // Append node where inDegree of node is zero
    for index in 0..<inDegree.count {
        if inDegree[index] == 0, index != 0{
            queue.insert(index)
        }
    }
    
    
    while !queue.isEmpty {
        let q = queue.pop()! // pop min node
        result.append(q)
        
        for adj in graph[q] {
            inDegree[adj] -= 1
            if inDegree[adj] == 0 {
                queue.insert(adj)
            }
        }
    }
    
    for r in result {
        print(r, terminator: " ")
    }
    print()
}
