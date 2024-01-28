// 15829

import Foundation

let L = Int(readLine()!)!
var cArr = readLine()!

let r = 31
let M = 1234567891

//DO IT!
solve()

func solve() {
  var result = 0

  for (index, c) in cArr.enumerated() {
    result += powWithMod(r: r, index: index) * (Int(c.asciiValue!) - 96) % M
  }
  
  print(result % M)
}

func powWithMod(r: Int, index: Int) -> Int {
  var result = 1
  
  for _ in 0..<index {
    result *= r
    result %= M
  }
  
  return result % M
}
