// #1874

import Foundation

struct Stack<T: Comparable> {
    var arr: [T] = []
    
    mutating func pop() -> T {
        return(arr.removeLast())
    }
    
    mutating func push(t: T) {
        arr.append(t)
    }
    
    func last() -> T? {
        if arr.isEmpty {
            return nil
        } else {
            return arr.last
        }
    }
}

let N = Int(readLine()!)!
var nums: [Int] = []
for _ in 1...N {
    nums.append(Int(readLine()!)!)
}

//DO IT!
solve()

func solve() {
    var stack = Stack<Int>()
    var resultString = ""
    var currentNum = 0
    
    for num in nums {
        let top = stack.last()
        
        if top != nil && top == num {
            _ = stack.pop()
            resultString += "-\n"
        } else if top != nil && top! > num {
            resultString = "NO"
            break
        } else {
            while currentNum < num {
                currentNum += 1
                stack.push(t: currentNum)
                resultString += "+\n"
            }
            
            let top = stack.last()
            if top != nil && top == num {
                _ = stack.pop()
                resultString += "-\n"
            }
        }
    }
    
    print(resultString)
}
