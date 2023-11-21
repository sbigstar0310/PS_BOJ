// # 2467

import Foundation

let N = Int(readLine()!)!
let solutions: [Int] = readLine()!.split(separator: " ").map {Int($0)!}

solve()

func solve() {
    var indexPair = (0, 0)
    var m = Int.max
    
    for index in 0..<solutions.count {
        let searchedIndex = binarySearch(index, solutions)
        //print("\(index) \(searchedIndex)")
        var (a, b, c) = (Int.max, Int.max, Int.max)
        if searchedIndex != 0 && index != searchedIndex - 1 {
            a = abs(solutions[index] + solutions[searchedIndex - 1])
            if a < m {
                m = a
                indexPair = index < searchedIndex - 1 ? (index, searchedIndex - 1) : (searchedIndex - 1, index)
            }
        }
        if index != searchedIndex {
            b = abs(solutions[index] + solutions[searchedIndex])
            if b < m {
                m = b
                indexPair = index < searchedIndex ? (index, searchedIndex) : (searchedIndex, index)
            }
        }
        if searchedIndex != solutions.count - 1 && index != searchedIndex + 1 {
            c = abs(solutions[index] + solutions[searchedIndex + 1])
            if c < m {
                m = c
                indexPair = index < searchedIndex + 1 ? (index, searchedIndex + 1) : (searchedIndex + 1, index)
            }
        }
        //print("\(a) \(b) \(c)")
    }
    
    print("\(solutions[indexPair.0]) \(solutions[indexPair.1])")
}

func binarySearch(_ index: Int, _ arr: [Int]) -> Int {
    var start = 0
    var end = arr.count - 1
    var resultIndex: Int = 0
    
    while start < end {
        let mid = (start + end) / 2
        
        if arr[mid] == (-1) * arr[index] {
            resultIndex = mid
            break
        }
        if arr[mid] > (-1) * arr[index] {
            end = mid
            resultIndex = mid
        } else {
            start = mid + 1
            resultIndex = mid
        }
    }
    
    return resultIndex
}
