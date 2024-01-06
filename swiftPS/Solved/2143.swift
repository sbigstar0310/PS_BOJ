// #2143
import Foundation

let T = Int(readLine()!)!
let N = Int(readLine()!)!
var A: [Int] = readLine()!.split(separator: " ").map {Int($0)!}

var M = Int(readLine()!)!
var B: [Int] = readLine()!.split(separator: " ").map {Int($0)!}


var dicA : [Int : Int] = [:]
var dicB : [Int : Int] = [:]

// DO IT!
solve()

func solve() {
    dicA = partialSumDic(A)
    dicB = partialSumDic(B)
    
    var result = 0
    
    for (key, cnt) in dicA {
        let searchValue = T - key
        if dicB.keys.contains(searchValue) {
            result += cnt * dicB[searchValue]!
        }
    }
    print(result)
}

func partialSumDic(_ A: [Int]) -> [Int : Int] {
    var pSum: [Int] = [0]
    var dic: [Int: Int] = [:]
    
    var sum = 0
    for a in A {
        sum += a
        pSum.append(sum)
    }
    
    for i in 0..<(pSum.count-1) {
        for j in (i+1)..<pSum.count {
            let num = pSum[j] - pSum[i]
            if dic.keys.contains(num) {
                dic[num]! += 1
            } else {
                dic[num] = 1
            }
        }
    }
    return dic
}
