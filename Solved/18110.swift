// #18110

import Foundation

let N = Int(readLine()!)!
let r = round(Double(N) * 0.15)

var nums: [Int] = []

for _ in 0..<N {
    let num = Int(readLine()!)!
    nums.append(num)
}

// DO IT!
solve()

func solve() {
    if N == 0 {
        print(0)
    } else {
        nums.sort()
        print(mean(nums))
    }
}

func mean(_ arr: [Int]) -> Int {
    var sum = 0
    
    for index in Int(r)..<(arr.count-Int(r)) {
        sum += arr[index]
    }
    
    return Int(round(Double(sum) / Double(arr.count - (2 * Int(r)))))
}
