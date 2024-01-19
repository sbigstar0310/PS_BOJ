// #1644

import Foundation

let N = Int(readLine()!)!

// DO IT!
solve()

func solve() {
    var resultCnt = 0
    let primeNums: [Bool] = findPrimUnder(N)
    let primeSums: [Int] = sumUp(primeNums)
    resultCnt = twoPointer(primeSums)
    print(resultCnt)
}

func sumUp(_ arr: [Bool]) -> [Int] {
    var sum = 0
    var resultArr: [Int] = [0]
    
    for index in 1..<arr.count {
        if arr[index] {
            sum += index
            resultArr.append(sum)
        }
    }
    
    return resultArr
}

func twoPointer(_ primeSums: [Int]) -> Int {
    var cnt = 0
    var left = 0
    var right = 0
    
    while left <= right && right < primeSums.count {
        let diff = primeSums[right] - primeSums[left]
        if diff > N {
            left += 1
        } else if diff < N {
            right += 1
        } else {
            cnt += 1
            right += 1
        }
    }
    
    return cnt
}

func findPrimUnder(_ n: Int) -> [Bool] {
    var result: [Bool] = Array(repeating: true, count: n+1)
    result[0] = false
    result[1] = false
    
    if n == 1 {
        return result
    } else if n == 2 {
        result[2] = true
        return result
    } else if n == 3 {
        result[2] = true
        result[3] = true
        return result
    }
    
    for i in 2...Int(sqrt(Double(n))) {
        var j = i + i
        while j <= n {
            result[j] = false
            j += i
        }
    }
    return result
}

