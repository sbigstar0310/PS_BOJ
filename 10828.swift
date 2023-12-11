// #10828

import Foundation

struct Stack<T: Comparable> {
    var arr: [T] = []
    
    mutating func push(_ X: T) {
        arr.append(X)
    }
    
    mutating func pop() -> T? {
        guard let last = arr.popLast() else {
            return nil
        }
        return last
    }
    
    func top() -> T? {
        guard let last = arr.last else {
            return nil
        }
        return last
    }
    
    func empty() -> Bool {
        return size() == 0
    }
    
    func size() -> Int {
        return arr.count
    }
}

let N = Int(readLine()!)!
var stack: Stack<Int> = Stack()

for _ in 1...N {
    let code = readLine()!.split(separator: " ")
    switch code[0] {
    case "push":
        let X = Int(code[1])!
        stack.push(X)
        
    case "pop":
        let last = stack.pop()
        last == nil ? print(-1) : print(last!)
        
    case "size":
        print(stack.size())
        
    case "empty":
        stack.empty() ? print(1) : print(0)
        
    case "top":
        let last = stack.top()
        last == nil ? print(-1) : print(last!)
        
    default:
        break
    }
}
