// #1202

import Foundation

struct MaxHeap<Element: Comparable> {
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
        
        while child > 0 && elements[child] > elements[parent] {
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
            
            if leftChild < count && elements[leftChild] > elements[candidate] {
                candidate = leftChild
            }
            
            if rightChild < count && elements[rightChild] > elements[candidate] {
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

struct Gem : Comparable {
    var weight: Int
    var cost: Int
    
    static func < (_ lhs: Gem, _ rhs: Gem) -> Bool {
        return lhs.cost < rhs.cost
    }
}

let line = readLine()!.split(separator: " ").map {Int($0)!}
let (N, K) = (line[0], line[1])
var gems: [(Int, Int)] = []
var bag: [Int] = []

for _ in 1...N {
    let line = readLine()!.split(separator: " ").map {Int($0)!}
    gems.append((line[0], line[1]))
}
for _ in 1...K {
    let weight = Int(readLine()!)!
    bag.append(weight)
}

// DO IT!
solve()

func solve() {
    var result = 0
    var heapq: MaxHeap<Gem> = MaxHeap()
    gems.sort {$0.0 < $1.0}
    bag.sort {$0 < $1}
    var gemsIndexPointer = 0
    for bagWeight in bag {
        while gemsIndexPointer < gems.count, gems[gemsIndexPointer].0 <= bagWeight {
            let gemWeight = gems[gemsIndexPointer].0
            let gemCost = gems[gemsIndexPointer].1
            heapq.insert(Gem(weight: gemWeight, cost: gemCost))
            gemsIndexPointer += 1
        }
        //print(heapq)
        let gem = heapq.pop()
        //print(gem)
        result += gem?.cost ?? 0
        //print(result)
    }
    print(result)
    
}
