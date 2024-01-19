// #2473
import Foundation

let N = Int(readLine()!)!
var numArr = readLine()!.split(separator: " ").map {Int($0)!}

// DO IT!
numArr.sort()
solve()

func solve() {
    var min = Int.max
    var resultArr = [Int]()
    
    for k in 0..<N-2 {
        var start = k + 1
        var end = N - 1
        
        while start < end {
            let target = numArr[start] + numArr[end] + numArr[k]
            
            if abs(min) > abs(target) {
                min = target
                resultArr = [numArr[start], numArr[end], numArr[k]]
            }
            
            if target > 0 {
                end -= 1
            } else {
                start += 1
            }
        }
    }
    
    for r in resultArr.sorted() {
        print(r, terminator: " ")
    }
    print()
}
