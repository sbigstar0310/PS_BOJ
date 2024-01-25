// #2108

import Foundation

let N = Int(readLine()!)!
var nums: [Int] = [Int]()

var numCount: [Int : Int] = [:]

for _ in 1...N {
    let num = Int(readLine()!)!
    if numCount.keys.contains(num) {
        numCount[num]! += 1
    } else {
        numCount[num] = 1
    }
    nums.append(num)
}

//DO IT!
solve()

func solve() {
    var result: (Int, Int, Int, Int) = (0, 0, 0, 0)
    
    let numCountArr = numCount.sorted { d1, d2 in
        if d1.value == d2.value {
            return d1.key < d2.key
        } else {
            return d1.value > d2.value
        }
    }
    nums.sort(by: <)
    result.0  = Int(round(getMean(arr: nums)))
    result.1 = nums[nums.count / 2]
    result.2 = {
        if numCountArr.count == 1 {
            return numCountArr[0].key
        }
        if numCountArr[0].value == numCountArr[1].value {
            return numCountArr[1].key
        } else {
            return numCountArr[0].key
        }
    }()
    result.3 = nums[nums.count - 1] - nums[0]
    
    print(result.0)
    print(result.1)
    print(result.2)
    print(result.3)
}

func getMean(arr: [Int]) -> Double {
    var sum = 0.0
    
    for e in arr {
        sum += Double(e)
    }
    
    return sum / Double(arr.count)
}
