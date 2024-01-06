// 9012

import Foundation

let T = Int(readLine()!)!
var result: [String] = []

for _ in 0..<T {
    let line = readLine()!
    var stack: [String] = []
    for c in line {
        if c == "(" {
            stack.append("(")
        } else {
            if stack.last == "(" {
                _ = stack.removeLast()
            }
            else {
                stack.append(")")
            }
        }
    }
    
    if stack.isEmpty {
        result.append("YES")
    } else {
        result.append("NO")
    }
}

for r in result {
    print(r)
}
