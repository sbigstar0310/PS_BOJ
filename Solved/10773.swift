// #10773

import Foundation

let N = Int(readLine()!)!
var nums: [Int] = []

for _ in 1...N {
  let num = Int(readLine()!)!
  nums.append(num)
}

//DO IT!
solve()

func solve() {
  var stack: [Int] = []
  var result = 0
  
  for num in nums {
    if num == 0 {
      _ = stack.removeLast()
    } else {
      stack.append(num)
    }
  }
  
  for ele in stack {
    result += ele
  }
  
  print(result)
}
