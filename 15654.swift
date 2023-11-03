// #15654

import Foundation

var line = readLine()!.split(separator: " ").map {Int($0)!}
let (N, M) = (line[0], line[1])
var numArr = readLine()!.split(separator: " ").map {Int($0)!}

// DO IT!
solve()



func solve() {
    // 1. Make permutation of P(N, M)
    var permutationArr = makePermutaion(numArr, M)

    // 2. Sort that permutation array
    permutationArr.sort(by: compareArr(arr1:arr2:))
    for arr in permutationArr {
        for element in arr {
            print(element, terminator: " ")
        }
        print()
    }
}

func compareArr(arr1: [Int], arr2: [Int]) -> Bool {
    for i in 0..<arr1.count {
        if arr1[i] == arr2[i] {
            continue
        }
        return arr1[i] < arr2[i]
    }
    return false
}

func makePermutaion(_ numArr: [Int], _ M: Int) -> [[Int]] {
    var result: [[Int]] = [[]]
    
    var visited = Array(repeating: false, count: numArr.count)
    
    func cycle(_ now: [Int]) {
        if now.count == M {
            result.append(now)
            return
        }
        
        for i in 0..<numArr.count {
            if visited[i] {
                continue
            } else {
                visited[i] = true
                cycle(now + [numArr[i]])
                visited[i] = false
            }
        }
    }
    
    cycle([])
    result.removeFirst()
    return result
}
